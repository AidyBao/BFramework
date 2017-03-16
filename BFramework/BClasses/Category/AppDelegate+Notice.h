//
//  AppDelegate+Notice.h
//  YDHYK
//
//  Created by JuanFelix on 30/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>

/**处理消息推送 友盟数据统计*/
@interface AppDelegate (Notice)<UNUserNotificationCenterDelegate>

- (void)zxn_application:(UIApplication *)application
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions;

+(void)isAllowedNotification:(void(^)(BOOL isAuthor))checkEnd;

@end
