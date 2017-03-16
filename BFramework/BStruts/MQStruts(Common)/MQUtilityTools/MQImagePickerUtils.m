//
//  MQImagePickerUtils.m
//  MQImagePickerUtils
//
//  JuanFelix on 2016/12/9.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQImagePickerUtils.h"
#import "MQCommonUtils.h"

#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface MQImagePickerUtils()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    MQTakeEndAction action;
}


@end


@implementation MQImagePickerUtils

-(void)takePhotoUponVC:(UIViewController *)vc
              callBack:(MQTakeEndAction)callBack{
    action = callBack;
    if ([MQImagePickerUtils isCameraAvailable] &&
        [MQImagePickerUtils doesCameraSupportTakingPhotos]) {
        UIImagePickerController * pickerVC = [[UIImagePickerController alloc] init];
        pickerVC.view.backgroundColor = [UIColor whiteColor];
        pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        pickerVC.mediaTypes = @[(__bridge NSString *)kUTTypeImage];
        pickerVC.allowsEditing = false;
        pickerVC.delegate = self;
        if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
            pickerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        if ([MQImagePickerUtils isAuthorized_jumpToSettingifNo:true]) {
            [vc presentViewController:pickerVC animated:true completion:nil];
        }
    }else{
        if (action) {
            action(nil,MQPCameraDisable,@"该设备不支持拍照");
        }
    }
}

- (void)choosePhotoUponVC:(UIViewController *)vc
                 callBack:(MQTakeEndAction)callBack{
    action = callBack;
    if ([MQImagePickerUtils isPhotoLibraryAvailable]) {
        UIImagePickerController * pickerVC = [[UIImagePickerController alloc] init];
        pickerVC.view.backgroundColor = [UIColor whiteColor];
        pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        NSMutableArray * mediaTypes = [NSMutableArray array];
        if ([MQImagePickerUtils canUsePickVideosFromPhotoLibrary]) {
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
        }
        pickerVC.mediaTypes = mediaTypes;
        pickerVC.allowsEditing = false;
        pickerVC.delegate = self;
        if ([[UIDevice currentDevice].systemVersion floatValue] > 8.0) {
            pickerVC.modalPresentationStyle = UIModalPresentationOverCurrentContext;
        }
        [vc presentViewController:pickerVC animated:true completion:nil];
    }else{
        if (action) {
            action(nil,MQPCameraDisable,@"该设备不支持资源选择");
        }
    }
}

//MARK: 照片获取完成
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    NSString * mediaType = info[UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:(__bridge NSString *)kUTTypeImage]) {
        UIImage * image = nil;
        if ([picker allowsEditing]) {
            image = info[UIImagePickerControllerEditedImage];
        }else{
            image = info[UIImagePickerControllerOriginalImage];
        }
        [picker dismissViewControllerAnimated:true completion:^{
            if (action) {
                action(image,MQPSuccess,nil);
            }
        }];
    }else{
        [picker dismissViewControllerAnimated:true completion:^{
            if (action) {
                action(nil,MQPNotImage,@"获取的不是图片");
            }
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:true completion:^{
        if (action) {
            action(nil,MQPCanceled,@"用户取消操作");
        }
    }];
}


//MARK: 用户是否授权
+ (BOOL)isAuthorized_jumpToSettingifNo:(BOOL)jump{
    NSString * mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus =  [AVCaptureDevice authorizationStatusForMediaType:mediaType];
//    AVAuthorizationStatusNotDetermined//未进行授权选择
//    AVAuthorizationStatusRestricted//未授权，且用户无法更新，如家长控制情况下
//    AVAuthorizationStatusDenied//用户拒绝App使用
//    AVAuthorizationStatusAuthorized//已授权，可使用
    if (authStatus == AVAuthorizationStatusDenied){
        if (jump) {
            [self showOpenSetting];
        }
        return false;
    }
    return true;
}

//MARK: 相机功能是否可用
+ (BOOL)isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

//MARK: 前置摄像头是否可用
+ (BOOL)isFrontCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

//MARK: 后置摄像头是否可用
+ (BOOL)isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

//MARK: 判断是否支持某种多媒体类型：拍照，视频
+ (BOOL)cameraSupportsMedia:(NSString *)mediaType
                 sourceType:(UIImagePickerControllerSourceType)sourceType{
    __block BOOL result = false;
    if (mediaType.length == 0) {
        return false;
    }
    NSArray * availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSString * type = obj;
        if ([type isEqualToString:mediaType]) {
            result = true;
            *stop = true;
        }
    }];
    return result;
}

//MARK: 检查摄像头是否支持录像
+ (BOOL)doesCameraSupportShootingVideos{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypeCamera];
}
//MARK: 检查摄像头是否支持拍照
+ (BOOL)doesCameraSupportTakingPhotos{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

//MARK: 相册是否可用
+ (BOOL)isPhotoLibraryAvailable {
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary];
}

//MARK: 是否可在相册中选择视频
+ (BOOL)canUsePickVideosFromPhotoLibrary{
//    return self.cameraSupportsMedia(kUTTypeMovie, sourceType: UIImagePickerControllerSourceType.PhotoLibrary)
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

//MARK: 是否可在相册中选择图片
+ (BOOL)canUserPickPhotosFromPhotoLibrary{
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

+ (void)showOpenSetting{
    UIViewController * rootVC = [[[UIApplication sharedApplication] windows].lastObject rootViewController];
    float sysVersion = [[UIDevice currentDevice].systemVersion floatValue];
    if (sysVersion > 8.0) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"您阻止了相机访问权限,请在设置中开启" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"马上打开" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [MQCommonUtils openApplicationURL:UIApplicationOpenSettingsURLString];
        }]];
        [rootVC presentViewController:alert animated:true completion:nil];
    }else{
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请在 '系统设置|隐私|相机' 中开启相机访问权限" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
        [rootVC presentViewController:alert animated:true completion:nil];
    }
}


@end
