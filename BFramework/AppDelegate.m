//
//  AppDelegate.m
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+Notice.h"
#import "UMessage.h"
#import "LaunchRootViewController.h"
#import "LoginRootViewController.h"
#import "LoginViewModel.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    isProcessed = true;
    //1.基本配置
    [MQCommonEngine loadAllConfig];
    
    //2.加载控制器
    [MQRootViewControllers reload];
    
    //3.切换根视图
    [MQRouter changeRootViewController:[[LaunchRootViewController alloc] init]];
    
    //MARK: UMENG
    [self bmn_application:application didFinishLaunchingWithOptions:launchOptions];
    
    //4.MARK:登录失败处理
    [MQNotificationCenter addObserver:self selector:@selector(loginInvalid) name:MQNOTICE_LOGIN_OFFLINE object:nil];
    
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {}


- (void)applicationDidEnterBackground:(UIApplication *)application {}


- (void)applicationWillEnterForeground:(UIApplication *)application {}


- (void)applicationDidBecomeActive:(UIApplication *)application {}


- (void)applicationWillTerminate:(UIApplication *)application {}

#pragma mark - 登录失效处理
- (void)loginInvalid{
    [LoginViewModel loginInvalidWith:isProcessed completion:^(BOOL reLogin) {
        isProcessed = reLogin;
    }];
}

#pragma mark - RemoteNotifcation
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error{
    
    NSString *error_str = [NSString stringWithFormat: @"%@", error];
    NSLog(@"Failed to get token, error:%@", error_str);
    
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken{
    NSString * strToken = [NSString stringWithFormat:@"%@",deviceToken];
    strToken = [strToken stringByReplacingOccurrencesOfString:@" " withString:@""];
    strToken = [strToken stringByReplacingOccurrencesOfString:@"<" withString:@""];
    strToken = [strToken stringByReplacingOccurrencesOfString:@">" withString:@""];
    //保存deviceToken
    [BBUserModel share].deviceToken = strToken;
    

    NSLog(@"deviceToken == %@",strToken);
}

//iOS10以下使用这个方法接收通知
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    //关闭友盟自带的弹出框
    [UMessage setAutoAlert:NO];
    [UMessage didReceiveRemoteNotification:userInfo];
    NSLog(@"<iOS10 :%@",userInfo);
    //from foreground
    //from background
    [MQRouter showNoticeDetail:userInfo];
}

//iOS10新增：处理前台收到通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions))completionHandler{
    //    response.notification.request.content.title
    NSMutableDictionary * userInfo = [notification.request.content.userInfo mutableCopy];
    [userInfo setObject:@(0) forKey:@"fromUserTap"];
    if([notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于前台时的远程推送接受
        //关闭友盟自带的弹出框
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
        [MQRouter showNoticeDetail:userInfo];
    }else{//应用处于前台时的本地推送接受
        NSLog(@"iOS10 接受本地通知:%@",userInfo);
    }
}

//iOS10新增：处理[点击]通知的代理方法
-(void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)())completionHandler{
    //    response.notification.request.content.title
    NSMutableDictionary * userInfo = [response.notification.request.content.userInfo mutableCopy];
    [userInfo setObject:@(1) forKey:@"fromUserTap"];
    if([response.notification.request.trigger isKindOfClass:[UNPushNotificationTrigger class]]) {
        //应用处于后台时的远程推送接受
        [UMessage setAutoAlert:NO];
        [UMessage didReceiveRemoteNotification:userInfo];
        [MQRouter showNoticeDetail:userInfo];
    }else{//应用处于后台时的本地推送接受
        NSLog(@"iOS10 点击本地通知:%@",userInfo);
    }
}


@end
