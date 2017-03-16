//
//  MQQRScanViewController.m
//  XXXX
//
//  Created by JuanFelix on 2016/12/5.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQQRScanViewController.h"

#import <AVFoundation/AVFoundation.h>

@interface MQQRScanViewController ()<AVCaptureMetadataOutputObjectsDelegate>{
    BOOL  checking;
}

@property (weak, nonatomic) IBOutlet UILabel * lbTtle;
@property (weak, nonatomic) IBOutlet UIView * navBackView;

@property (weak, nonatomic) IBOutlet UIView * contentView;//承载图像
@property (weak, nonatomic) IBOutlet UIView * scanFrame;  //扫描区域

@property (strong, nonatomic) UIImageView * animationImage;
@property (nonatomic, strong) AVCaptureSession *session;

@end

@implementation MQQRScanViewController

+ (MQQRScanViewController *)startScanInViewController:(UIViewController *)vc asPush:(BOOL)push autoDismiss:(BOOL)autoDismiss callBack:(MQQRCallBack)callBack{
    MQQRScanViewController * scanVC = [[MQQRScanViewController alloc] init];
    scanVC.mqQRCallBack = callBack;
    scanVC.autoDismiss = autoDismiss;
    if (push) {
        if ([vc isKindOfClass:[UINavigationController class]]) {
            [(UINavigationController *)vc pushViewController:scanVC animated:true];
        }else if (vc.navigationController){
            [vc.navigationController pushViewController:scanVC animated:true];
        }else{
            [vc presentViewController:scanVC animated:true completion:nil];
        }
    }else{
        [vc presentViewController:scanVC animated:true completion:nil];
    }
    return scanVC;
}

- (instancetype)init{
    if (self = [super init]) {
        [self setHidesBottomBarWhenPushed:true];
        [self setFd_prefersNavigationBarHidden:true];
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self checkEnvironmentAndRun];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}


- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self stopScan];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    checking = false;
    [self.scanFrame setBackgroundColor:[UIColor clearColor]];
    [self.lbTtle setFont:[UIFont mq_titleFontWithSize:mq_navBarTitleFontSize()]];
    //
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(s_enterBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(s_enterForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
}

- (void)s_enterBackground{
    _animationImage.layer.timeOffset = CACurrentMediaTime();
}

- (void)s_enterForeground{
    [self resumeAnimation];
}


//MARK: - 相机环境检测
- (void)checkEnvironmentAndRun{
    AVAuthorizationStatus  authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    switch (authStatus) {
        case AVAuthorizationStatusAuthorized:
        {
            [self beginScanning];
        }
            break;
        case AVAuthorizationStatusDenied:
        {
            if (MQ_IOS8_OR_LATER) {
                [self showAAlertWithTitle:@"提示" message:@"您阻止了相机访问权限,请在设置中开启" buttonTexts:@[@"取消",@"马上打开"] buttonAction:^(int buttonIndex) {
                    if (buttonIndex == 1) {
                        #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString] options:@{} completionHandler:nil];
                        #else
                            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
                        #endif
                    }
                }];
            }else{
                [self showAAlertWithTitle:@"提示" message:@"请在 '系统设置|隐私|相机' 中开启相机访问权限" buttonTexts:@[@"知道了"] buttonAction:nil];
            }
        }
            break;
        case AVAuthorizationStatusNotDetermined:
        {
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if (granted) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self beginScanning];
                    });
                    
                }
            }];
        }
            break;
        case AVAuthorizationStatusRestricted:
        {
            [self showAAlertWithTitle:@"提示" message:@"相机访问受限" buttonTexts:@[@"知道了"] buttonAction:nil];
        }
            break;
        default:
            break;
    }
}

- (void)stopScan{
    if (_session && [_session isRunning]) {
        [_session stopRunning];
    }
    [_animationImage.layer removeAllAnimations];
}

- (void)restartScan{
    if (_session) {
        if ([_session isRunning]) {
            return;
        }
        [_session startRunning];
        [self resumeAnimation];
    }
}

//MARK: - 漏空遮罩层
- (void)addMaskLayer{
    CALayer * maskLayer = [[CALayer alloc] init];
    maskLayer.frame = [UIScreen mainScreen].bounds;
    maskLayer.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.6].CGColor;
    CAShapeLayer * empty = [CAShapeLayer layer];
    UIBezierPath * path = [UIBezierPath bezierPathWithRect:maskLayer.frame];
    CGRect frame = self.scanFrame.frame;
    [path appendPath:[[UIBezierPath bezierPathWithRoundedRect:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height) cornerRadius:0] bezierPathByReversingPath]];
    empty.path = path.CGPath;
    maskLayer.mask = empty;
    
    [self.contentView.layer insertSublayer:maskLayer below:_navBackView.layer];
    
    _animationImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"scan_net"]];
}

- (void)beginScanning
{
    if (!_session) {
        //获取摄像设备
        AVCaptureDevice * device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        AVCaptureDeviceInput * input = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];//输入流
        if (!input) {
            [self showAAlertWithTitle:@"提示" message:@"相机不可用" buttonTexts:@[@"知道了"] buttonAction:nil];
            return;
        }
        AVCaptureMetadataOutput * output = [[AVCaptureMetadataOutput alloc]init];//输出流
        //设置代理 在主线程里刷新
        [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
        //设置有效扫描区域
        CGRect scanCrop=[self getScanCrop:self.scanFrame.frame readerViewBounds:self.contentView.bounds];
        //设置扫描范围CGRectMake(Y,X,H,W),1代表最大值 右上角基准
        output.rectOfInterest = scanCrop;
        //初始化链接对象
        _session = [[AVCaptureSession alloc]init];
        //高质量采集率
        [_session setSessionPreset:AVCaptureSessionPresetHigh];
        [_session addInput:input];
        [_session addOutput:output];
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容,)
        output.metadataObjectTypes=@[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeCode128Code,AVMetadataObjectTypeEAN8Code,AVMetadataObjectTypeEAN13Code,AVMetadataObjectTypeCode39Code,AVMetadataObjectTypeCode93Code,AVMetadataObjectTypeUPCECode,AVMetadataObjectTypeCode39Mod43Code,AVMetadataObjectTypePDF417Code,AVMetadataObjectTypeAztecCode,AVMetadataObjectTypeITF14Code,AVMetadataObjectTypeDataMatrixCode];
        
        AVCaptureVideoPreviewLayer * layer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
        layer.videoGravity=AVLayerVideoGravityResizeAspectFill;
        layer.frame= CGRectMake(0, 0, MQ_BOUNDS_WIDTH, MQ_BOUNDS_HEIGHT);
        [self.contentView.layer insertSublayer:layer atIndex:0];
        [self addMaskLayer];//添加漏空层遮罩
    }
    [self restartScan];
}

//MARK: - 恢复动画
- (void)resumeAnimation
{
    CAAnimation *anim = [_animationImage.layer animationForKey:@"translationAnimation"];
    if(anim){
        CFTimeInterval pauseTime = _animationImage.layer.timeOffset;
        CFTimeInterval beginTime = CACurrentMediaTime() - pauseTime;
        [_animationImage.layer setTimeOffset:0.0];
        [_animationImage.layer setBeginTime:beginTime];
        [_animationImage.layer setSpeed:1.0];
    }else{
        CGFloat scanNetImageViewH = self.scanFrame.frame.size.height;
        CGFloat scanNetImageViewW = self.scanFrame.frame.size.width;
        _animationImage.frame = CGRectMake(0, -scanNetImageViewH, scanNetImageViewW, scanNetImageViewH);
        CABasicAnimation *scanNetAnimation = [CABasicAnimation animation];
        scanNetAnimation.keyPath = @"transform.translation.y";
        scanNetAnimation.byValue = @(scanNetImageViewW);
        scanNetAnimation.duration = 1.0;
        scanNetAnimation.repeatCount = MAXFLOAT;
        [_animationImage.layer addAnimation:scanNetAnimation forKey:@"translationAnimation"];
        [self.scanFrame addSubview:_animationImage];
    }
}

//MARK: - 获取扫描区域的比例关系
- (CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    x = rect.origin.y / CGRectGetHeight(readerViewBounds);
    y = (CGRectGetWidth(readerViewBounds) - CGRectGetWidth(rect)) / 2 / CGRectGetWidth(readerViewBounds);
    width  = CGRectGetHeight(rect)/CGRectGetHeight(readerViewBounds);
    height = CGRectGetWidth(rect)/CGRectGetWidth(readerViewBounds);
    return CGRectMake(x, y, width, height);//(Y,X,W,H)
}

//MARK: - AVCaptureMetadataOutputObjects Delegate
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection{
    if (checking) {
        return;
    }
    checking = true;
    if (metadataObjects.count > 0) {
        [self stopScan];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        NSString *result = metadataObject.stringValue;
        self.mqQRCallBack(result);
    }else{
        self.mqQRCallBack(nil);
    }
}

//MARK: - AlertUtils
- (void)showAAlertWithTitle:(NSString *)title
                    message:(NSString *)msg
                buttonTexts:(NSArray *)arrTexts
               buttonAction:(void (^)(int buttonIndex))buttonAction{
    if (arrTexts && arrTexts.count) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:title ? title : @"提示" message:msg preferredStyle:UIAlertControllerStyleAlert];
        int index = 0;
        for (NSString * strText in arrTexts) {
            [alert addAction:[UIAlertAction actionWithTitle:strText ? strText :@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                if (buttonAction) {
                    buttonAction(index);
                }
            }]];
            index++;
        }
        [self presentViewController:alert animated:true completion:nil];
    }
}

- (IBAction)backAction:(id)sender {
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:true];
    }else{
        [self dismissViewControllerAnimated:true completion:nil];
    }
}

- (void)dismiss{
    [self backAction:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
