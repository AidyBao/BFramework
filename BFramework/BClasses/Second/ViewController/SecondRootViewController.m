//
//  SecondRootViewController.m
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "SecondRootViewController.h"
#import "SplitViewController.h"

@interface SecondRootViewController ()

@end

@implementation SecondRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"Second";
}

#pragma mark - 检查更新
- (IBAction)checkUpdate:(id)sender {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [MQCheckUpdate checkUpdate:^(BOOL needUpdate, NSString *updateURL, BOOL appStoreType) {
            if (needUpdate) {
                NSString * strInfo = @"去更新";
                if (!appStoreType) {
                    strInfo = @"马上更新";
                }
                [MQAlertUtils showAAlertWithTitle:@"提示" message:@"有新版本更新!" buttonText:strInfo buttonAction:^{
                    [MQCommonUtils openApplicationURL:updateURL];
                }];
            }
        }];
    });
}

#pragma mark - 导航栏左右视图
- (IBAction)testRigthLeftBtn:(id)sender {
    
    //2.设置导航栏右边视图
    [self mq_addRightBarItemsWithTexts:@[@"保存"] font:[UIFont systemFontOfSize:mq_title1FontSize()] color:[UIColor orangeColor]];
    
    [self mq_addLeftBarItemsWithTexts:@[@"设置"] font:[UIFont systemFontOfSize:mq_title1FontSize()] color:[UIColor orangeColor]];
}

-(void)mq_rightBarButtonActionsIndex:(NSInteger)index{
    NSLog(@"保存");
}
-(void)mq_leftBarButtonActionsIndex:(NSInteger)index{
    NSLog(@"设置");
}

#pragma mark - 颜色
- (IBAction)testColor:(id)sender {
    
    NSLog(@"%@",[UIColor mq_textColor]);
    NSLog(@"%@",[UIColor mq_tintColor]);
    NSLog(@"%@",[UIColor mq_assistColor]);
    NSLog(@"%@",[UIColor mq_borderColor]);
    NSLog(@"%@",[UIColor mq_navbarColor]);
    NSLog(@"%@",[UIColor mq_tabbarColor]);
    NSLog(@"%@",[UIColor mq_customAColor]);
    NSLog(@"%@",[UIColor mq_customBColor]);
    NSLog(@"%@",[UIColor mq_backgroundColor]);
    
}

#pragma mark - 打开URL
- (IBAction)testOpenUrl:(id)sender {
    //打开URL
    [MQCommonUtils openApplicationURL:@"https://www.baidu.com"];
    
    //拨打电话
    [MQCommonUtils openCallWithTelNum:@"13800138000"];
}

#pragma makr - 获取配置相关信息
- (IBAction)testBundle:(id)sender {
    
    //获取ZXSetting Bundle
    NSLog(@"%@",[NSBundle mq_settingBundle]);
    
    //获取 按钮 配置文件路径
    NSLog(@"%@",[NSBundle pathForButtonConfig]);
    
    //获取 字体 配置
    NSLog(@"%@",[NSBundle pathForFontConfig]);
    
    //获取 NavgationBar 配置文件路径
    NSLog(@"%@",[NSBundle pathForNavBarConfig]);
    
    //获取 Tabbar 配置文件路径
    NSLog(@"%@",[NSBundle pathForTabBarConfig]);
    
    
    //获取 程序主色调 配置文件路径
    NSLog(@"%@",[NSBundle pathForTintColorConfig]);
    
    //从ZXSetting 获取导航栏返回图片
    NSLog(@"%@",[NSBundle mq_navBackImage]);

}

#pragma mark - 图片处理
- (IBAction)testImage:(id)sender {
    //尺寸和质量压缩
    [UIImage mq_scaleImageWithImage:[UIImage imageNamed:@""] toSize:CGSizeMake(120, 120)];
    //将裁剪后不规则的图片，裁剪为正方形
    [UIImage mq_cutImageToSquare:[UIImage imageNamed:@""]];
    //固定图片方向
    [UIImage mq_fixOrientation:[UIImage imageNamed:@""]];
    
    //用户是否授权 如果未授权是否跳转到设置界面(iOS8之后)
    [MQImagePickerUtils isAuthorized_jumpToSettingifNo:YES];
    
    //相机功能是否可用
    [MQImagePickerUtils isCameraAvailable];
    //前置摄像头是否可用
    [MQImagePickerUtils isFrontCameraAvailable];
    //后置摄像头是否可用
    [MQImagePickerUtils isRearCameraAvailable];
    //判断是否支持某种多媒体类型：拍照，视频
    [MQImagePickerUtils cameraSupportsMedia:[NSString stringWithFormat:@""] sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    //检查摄像头是否支持录像
    [MQImagePickerUtils doesCameraSupportShootingVideos];
    //检查摄像头是否支持拍照
    [MQImagePickerUtils doesCameraSupportTakingPhotos];
    //相册是否可用
    [MQImagePickerUtils isPhotoLibraryAvailable];
    //是否可在相册中选择视频
    [MQImagePickerUtils canUsePickVideosFromPhotoLibrary];
    //是否可在相册中选择图片
    [MQImagePickerUtils canUserPickPhotosFromPhotoLibrary];
    
    
    //    /**拍照*/
    //    - (void)takePhotoUponVC:(UIViewController *)vc
    //callBack:(ZXTakeEndAction)callBack;
    //    /**从相册取*/
    //    - (void)choosePhotoUponVC:(UIViewController *)vc
    //callBack:(ZXTakeEndAction)callBack;
    //
}

#pragma mark - 键盘将要显示、隐藏事件
- (IBAction)testKkeyBoard:(id)sender {

    //添加键盘 【Will】显示 和 隐藏通知
    [self mq_addKeyboardNotification];
    //移除键盘 【Will】显示 和 隐藏通知
//    [self mq_removeKeyboardNotification];
}

//键盘 【Will】消失事件时间
-(void)mq_keyboardWillHideTimeInteval:(double)dt notice:(NSNotification *)notice{
    NSLog(@"键盘 【Will】消失事件时间");
}

//键盘 【Will】显示事件时间
-(void)mq_keyboardWillShowTimeInteval:(double)dt notice:(NSNotification *)notice{
    NSLog(@"键盘 【Will】显示事件时间");
}
//键盘 变换大小
-(void)mq_keyboardWillChangeFrameBeginRect:(CGRect)beginRect endRect:(CGRect)endRect timeInterval:(double)dt notice:(NSNotification *)notice{
    NSLog(@"键盘 变换大小");
}

#pragma mark - 通知
- (IBAction)testNotice:(id)sender {
    
    [MQNotificationCenter addObserver:self selector:@selector(notice) name:@"" object:nil];
    [MQNotificationCenter removeObserver:self name:@"" object:nil];
    [MQNotificationCenter postNotificationName:@"" object:nil];
   
}

#pragma mark - 通知内容处理
- (IBAction)testNoticeContent:(id)sender {
}

#pragma mark - 扫描
- (IBAction)testScan:(id)sender {
   
    [MQQRScanViewController startScanInViewController:self asPush:YES autoDismiss:YES callBack:^(NSString *information) {
        
    }];
    
    MQQRScanViewController *vc = [[MQQRScanViewController alloc]init];
    [vc stopScan];
    [vc restartScan];
    
}

- (IBAction)split:(id)sender {
   
    SplitViewController *splitVC = [[UIStoryboard storyboardWithName:@"Second" bundle:nil]instantiateViewControllerWithIdentifier:NSStringFromClass([SplitViewController class])];

    [self presentViewController:splitVC animated:YES completion:nil];
}


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
