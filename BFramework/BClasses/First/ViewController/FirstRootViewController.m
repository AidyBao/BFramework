//
//  FirstRootViewController.m
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "FirstRootViewController.h"
#import "SecondRootViewController.h"

@interface FirstRootViewController ()

@end

@implementation FirstRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"First";
    
    NSLog(@"%@",[APPManager getNoticeDeviceToken]);
}

#pragma mark - 测试跳转
- (IBAction)testRouter:(id)sender {
    
    //1.跳转其他控制器
    SecondRootViewController *secondVC = [[SecondRootViewController alloc]init];
    UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:secondVC];
    //1.1 根控制器变换
//    [MQRouter changeRootViewController:navVC];
    //1.2 push到下级页面
    [self.navigationController pushViewController:secondVC animated:YES];
    
   
    //获取keyWindow
    NSLog(@"%@",[MQRootViewControllers keyController]);
    
    //
    NSLog(@"%@",[MQRootViewControllers appWindow]);
}

#pragma mark - 测试弹窗
- (IBAction)testAlert:(id)sender {
    
    //无事件处理
    [MQAlertUtils showAAlertWithTitle:@"确定" message:@"确认成功"];
    
    //多事件处理
    [MQAlertUtils showActionSheetWithTitle:@"提示" buttonTexts:@[@"确认",@"取消"] buttonAction:^(int buttonIndex) {
        NSLog(@"%d",buttonIndex);
    }];
    
    //但事件处理
    [MQAlertUtils showAAlertWithTitle:@"提示" message:@"确认取消" buttonText:@"确定" buttonAction:^{
        
    }];
    
    //多事件处理
    [MQAlertUtils showAAlertWithTitle:@"提示" message:@"确认取消" buttonTexts:@[@"确认",@"取消"] buttonAction:^(int buttonIndex) {
        NSLog(@"%d",buttonIndex);
    }];
}

#pragma mark - 测试二维码
- (IBAction)testQRCode:(id)sender {
    [MQQRScanViewController startScanInViewController:self asPush:YES autoDismiss:NO callBack:^(NSString *information) {
        NSLog(@"%@",information);
    }];
    
//    ZXQRScanViewController *vc = [[ZXQRScanViewController alloc]init];
//    [vc stopScan];
//    [vc restartScan];
    
}

#pragma mark - 测试字体
- (IBAction)testFont:(id)sender {
    
    NSLog(@"%@",[UIFont systemFontOfSize:mq_title1FontSize()]);
    
    NSLog(@"%@",[UIFont systemFontOfSize:mq_title2FontSize()]);
    
    NSLog(@"%@",[UIFont systemFontOfSize:mq_tabBarItemTitleFontSize()]);
    
    NSLog(@"%@",[UIFont systemFontOfSize:mq_buttonTitleFontSize()]);
    
    NSLog(@"%@",[UIFont systemFontOfSize:mq_navBarButtonTitleFontSize()]);
    
    NSLog(@"%@",[UIFont mq_bodyFontWithSize:0]);
    
    NSLog(@"%@",[UIFont mq_iconfontWithSize:0]);
    
    NSLog(@"%@",[UIFont mq_customAFontWithSize:0]);
    
    NSLog(@"%@",[UIFont mq_titleFontWithSize:0]);
    
}

#pragma mark - 测试网络请求
- (IBAction)testNetworking:(id)sender {
    
    NSString *apiAddress = @"";
    
    NSMutableDictionary *paramsDict = [[NSMutableDictionary alloc]initWithCapacity:3];
   
    [MQHUD MBShowLoadingInView:self.view text:nil delay:0];
    [MQNetworkEngine asyncRequestWithURL:MQAPI_Address(apiAddress) params:paramsDict token:[APPManager getToken] method:POST mqCompletion:^(id content, NSInteger status, BOOL success, NSString *errorMsg) {
        [MQHUD MBHideForView:self.view animate:true];
        [MQEmptyView dismissInView:self.view];
        
        if (status == MQAPI_SUCCESS) {//成功

        
        }else{//失败
            if (status != MQAPI_LOGIN_INVALID) {
                [MQEmptyView showNetworkErrorInView:self.view heightFix:0 refreshAction:^{
                        [MQEmptyView dismissInView:self.view];
                }];
            }else{
                [MQHUD MBShowFailureInView:self.view text:errorMsg delay:1.2];
            }
        }
    }];
}

#pragma mark - 测试Web
- (IBAction)testWeb:(id)sender {
    
    MQWebEngine *webEngine = [[MQWebEngine alloc]init];
    [webEngine loadContentWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    
//    [webEngine loadContentWithHTMLString:@"https://www.baidu.com" baseURL:nil];
    [self.navigationController pushViewController:webEngine animated:YES];
}

#pragma mark - 测试HUD
- (IBAction)testHUD:(id)sender {
    //
    [MQCommonUtils showNetworkActivityIndicatorVisible:true];
    
    //
    [MQCommonUtils showNetworkActivityIndicatorVisible:false];
    
    //
    [MQHUD MBShowFailureInView:self.view text:MQ_LOADING_TEXT delay:1.0];
    
    //
    [MQHUD MBShowFailureInView:self.view text:@"失败" delay:1.0];
    
    //
    [MQHUD MBShowSuccessInView:self.view text:@"成功" delay:1.0];
    
    [MQHUD MBHideForView:self.view animate:TRUE];
}

#pragma mark - 测试没有数据
- (IBAction)testNoData:(id)sender {
    [MQEmptyView showNoDataInView:self.view text1:@"无数据" text2:nil heightFix:0];
    [MQEmptyView dismissInView:self.view];
}

#pragma mark - 测试没有网络
- (IBAction)testNoNetworking:(id)sender {
    [MQEmptyView showNetworkErrorInView:self.view heightFix:0 refreshAction:^{
        [MQEmptyView dismissInView:self.view];
    }];
}

#pragma mark - 测试解码
- (IBAction)testBase64:(id)sender {
    
    //解码
    NSString *str = @"123456";
    NSData *qrData = [str base64DecodedData];
    NSLog(@"%@",qrData);
    
    //解码
    NSLog(@"%@",[str base64DecodedString]);
    
    //编码
    NSLog(@"%@",[str base64EncodedString]);
    
}

#pragma mark - 测试获取App信息
- (IBAction)testAPPInfro:(id)sender {
   
    NSLog(@"%@",[MQCommonUtils getBundleId]);
    NSLog(@"%@",[MQCommonUtils getBundleBuild]);
    NSLog(@"%@",[MQCommonUtils getBundleVersion]);
}

#pragma mark - 测试时间处理
- (IBAction)testDate:(id)sender {
    
    NSString *last = @"2012-02-02";
    NSString *next = @"2012-03-03";
    [MQDateUtils compareWithLastDate:last withNextDate:next];
    NSLog(@"%@",[MQDateUtils getCurrentDateisChinese:YES]);
    NSLog(@"%@",[MQDateUtils getCurrentTimeNeedSecond:YES]);
    NSLog(@"%@",[MQDateUtils getDateAfterTodayMillSeconds:@50]);
    NSLog(@"%@",[MQDateUtils getCurrentDate_TimeWithSecond:YES isChinese:YES]);
}

#pragma mark - 测试手机信息
- (IBAction)testTelphone:(id)sender {
    
    NSLog(@"%@",[MQDevice MQ_DeviceType]);
    
    NSLog(@"%@",[MQDevice MQ_DeviceUUID]);
    
    NSLog(@"%@",[MQDevice MQ_DeviceSystem]);
    
    NSLog(@"%@",[MQDevice MQ_DeviceVersion]);
}

#pragma mark - 测试字符串的处理
- (IBAction)testString:(id)sender {
    
    NSString *str = @"123456";
    
    //是否为中文
    NSLog(@"%d",[MQStringUtils isChinese:str]?1:0) ;
    
    //是否为空
    NSLog(@"%d",[MQStringUtils isTextEmpty:str]?1:0);
    
    //是否邮件
    NSLog(@"%d",[MQStringUtils isEmailValid:str]?1:0);
    
    //6-20 位字母+数字
    NSLog(@"%d",[MQStringUtils isPasswordValid:str]?1:0);
    
    //判断某个字符串是否匹配某个正则
    NSLog(@"%d",[MQStringUtils isString:str matchingRegularString:@""]?1:0);
    
    //文字添加删除线 或下划线
    [NSAttributedString mq_addLineToText:@"123456" type:MQUnderLine atRange:NSMakeRange(1, 3)];
    [NSAttributedString mq_addLineToText:@"123456" type:MQDeleteLine atRange:NSMakeRange(1, 3)];
    
    //修改字符串 某段文字颜色
//    [NSAttributedString mq_addColorToText:@"123456" withColor:[UIColor orangeColor] atRange:NSMakeRange(3, 5)];

    //修改字符串 某段文字字体 可以为空
    [NSAttributedString mq_addFontToText:@"123456789" withFont:[UIFont mq_bodyFontWithSize:0] atRange:NSMakeRange(3, 5)];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
