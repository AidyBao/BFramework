//
//  AppDelegate+Notice.m
//  YDHYK
//
//  Created by JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//  友盟推送

#import "AppDelegate+Notice.h"
#import "UMessage.h"
#import <UMMobClick/MobClick.h>

#define UM_KEY_APPSTORE         @""
#define UM_KEY_ENTERPRISE       @"58c62b2107fe65294b001931"

@implementation AppDelegate (Notice)

- (void)bmn_application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions{
    if (launchOptions) {
        NSDictionary*userInfo = [launchOptions objectForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
        if(userInfo)
        {
            [self bmn_didReceiveRemoteNotification:userInfo];
        }
    }
    NSString * UM_KEY = UM_KEY_APPSTORE;//AppStore
    if ([[MQCommonUtils getBundleId] isEqualToString:ENTERPRISE_BUNDLE_ID]) {
        UM_KEY = UM_KEY_ENTERPRISE;//Enterprise
    }
    //UM
    [UMessage startWithAppkey:UM_KEY launchOptions:launchOptions];
    //UM 统计
    UMConfigInstance.appKey = UM_KEY;
    if ([[MQCommonUtils getBundleId] isEqualToString:ENTERPRISE_BUNDLE_ID]) {
        UMConfigInstance.channelId = @"Enterprise";
    }else{
        UMConfigInstance.channelId = @"App Store";
    }
    [MobClick startWithConfigure:UMConfigInstance];//配置以上参数后调用此方法初始化SDK！
    //LOG
    [UMessage setLogEnabled:YES];
    //测试
    [self registRemoteNotification];
}

-(void)bmn_didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    NSError *parseError = nil;
    NSData  *jsonData = [NSJSONSerialization dataWithJSONObject:userInfo
                                                        options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *str =  [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",str);
}

//MARK:注册消息推送
-(void)registRemoteNotification{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    center.delegate=self;
    UNAuthorizationOptions types10=UNAuthorizationOptionBadge|  UNAuthorizationOptionAlert|UNAuthorizationOptionSound;
    [center requestAuthorizationWithOptions:types10     completionHandler:^(BOOL granted, NSError * _Nullable error) {
        if (granted) {
            //点击允许
        } else {
            //点击不允许
            [self showAlertisAllowNotice:false];
        }}
     ];
    [[UIApplication sharedApplication] registerForRemoteNotifications];
#elif __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0
    [self showAlertisAllowNotice:[AppDelegate isAllowedNotificationLessiOS10]];
    UIUserNotificationSettings *settings = [UIUserNotificationSettings
                                            settingsForTypes:
                                            (UIUserNotificationTypeBadge
                                             | UIUserNotificationTypeSound
                                             | UIUserNotificationTypeAlert)
                                            categories:nil];
    [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
#else
    [self showAlertisAllowNotice:[AppDelegate isAllowedNotificationLessiOS10]];
    [[UIApplication sharedApplication] registerForRemoteNotificationTypes:UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound | UIRemoteNotificationTypeAlert];
#endif
}

- (void)showAlertisAllowNotice:(BOOL)allow{
    if (!allow) {
        if (![AppDelegate needShowNoticeAlert]) {
            return;
        }
        //访问被拒绝
        if (MQ_IOS8_OR_LATER) {
            [MQAlertUtils showAAlertWithTitle:@"提示" message:@"您阻止了程序接受消息,可能会错过提醒消息哦!" buttonTexts:@[@"不再提示",@"马上打开"] buttonAction:^(int buttonIndex) {
                switch (buttonIndex) {
                    case 0:
                    {
                        [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"ZX_Not_Show_Alert"];
                        [[NSUserDefaults standardUserDefaults] synchronize];
                    }
                        break;
                    case 1:
                    {
                        [MQCommonUtils openApplicationURL:UIApplicationOpenSettingsURLString];
                    }
                        break;
                    default:
                        break;
                }
            }];
        }else{
            [MQAlertUtils showAAlertWithTitle:@"提示" message:@"您阻止了程序接受消息,可能会错过提醒消息哦!可在 '系统设置|通知' 中开启" buttonTexts:@[@"不再提示",@"知道了"] buttonAction:^(int buttonIndex) {
                if (buttonIndex == 0) {
                    [[NSUserDefaults standardUserDefaults] setObject:@(1) forKey:@"ZX_Not_Show_Alert"];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
            }];
        }
    }
}


+(void)isAllowedNotification:(void(^)(BOOL isAuthor))checkEnd {
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
    [center getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {
        if (settings.authorizationStatus == UNAuthorizationStatusAuthorized) {
            if (checkEnd) {
                checkEnd(true);
            }
        }else{
            if (checkEnd) {
                checkEnd(false);
            }
        }
    }];
    //iOS8 check if user allow notification
#elif (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0 && __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_10_0)
    UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        if (checkEnd) {
            checkEnd(true);
        }
    }else{
        if (checkEnd) {
            checkEnd(false);
        }
    }
#elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if(UIRemoteNotificationTypeNone != type){
        if (checkEnd) {
            checkEnd(true);
        }
    }else{
        if (checkEnd) {
            checkEnd(false);
        }
    }
#endif
    
}

+(BOOL)isAllowedNotificationLessiOS10{
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_8_0 && __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_10_0)
        UIUserNotificationSettings *setting = [[UIApplication sharedApplication] currentUserNotificationSettings];
    if (UIUserNotificationTypeNone != setting.types) {
        return true;
    }else{
        return false;
    }
#elif __IPHONE_OS_VERSION_MAX_ALLOWED < __IPHONE_8_0
    UIRemoteNotificationType type = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
    if(UIRemoteNotificationTypeNone != type){
        return true;
    }else{
        return false;
    }
#endif
    return true;
}

//未开启消息推送通知提示
+ (BOOL)needShowNoticeAlert{
    id obj = [[NSUserDefaults standardUserDefaults] objectForKey:@"ZX_Not_Show_Alert"];
    if (obj && [obj isKindOfClass:[NSNumber class]]) {
        if ([obj intValue] == 1) {
            return false;
        }
    }
    return true;
}

@end
