//
//  MQRootViewControllers.m
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQRootViewControllers.h"
#import "UITabBarController+MQ.h"
#import "UIColor+MQColor.h"
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@implementation MQRootViewControllers

static UITabBarController * mq_tarbarvc = nil;


+ (void)reload{
    mq_tarbarvc = nil;
    id delegate = [UIApplication sharedApplication].delegate;
    if (delegate) {
        [self mq_tabbarController].delegate = delegate;
    }
    [MQRootViewControllers loadfromPlistWithControllerClassNames:@[@"FirstRootViewController",@"SecondRootViewController",@"ThreeRootViewController",@"FourRootViewController"]];
    [[MQRootViewControllers mq_tabbarController] setSelectedIndex:0];
}

+ (UITabBarController *)mq_tabbarController{
    if (!mq_tarbarvc) {
        mq_tarbarvc = [[UITabBarController alloc] init];
        
        [mq_tarbarvc.tabBar.layer setShadowColor:[UIColor mq_colorWithHEXString:@"4f8ee5" alpha:1.0].CGColor];
        [mq_tarbarvc.tabBar.layer setShadowRadius:5];
        [mq_tarbarvc.tabBar.layer setShadowOffset:CGSizeMake(0, -2)];
        [mq_tarbarvc.tabBar.layer setShadowOpacity:0.25];
    }
    return mq_tarbarvc;
}

+ (void)loadfromPlistWithControllerClassNames:(NSArray<NSString *> *)classNames{
    if (classNames && classNames.count) {
        [classNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //Plist 中已设置嵌入NavigationController
            Class class = NSClassFromString(obj);
            [[self mq_tabbarController] mq_addChildViewController:[[class alloc] init] atPlistIndex:idx];
        }];
    }else{
        [[self mq_tabbarController] setViewControllers:nil];
    }
}

+ (void)reloadfromPlistWithControllerClassNames:(NSArray<NSString *> *)classNames{
    mq_tarbarvc = nil;
    id delegate = [UIApplication sharedApplication].delegate;
    if (delegate) {
        [self loadfromPlistWithControllerClassNames:classNames];
        [self mq_tabbarController].delegate = delegate;
    }
}

+ (UIViewController *)keyController{
    UIViewController * keyController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    do{
        if (keyController.presentedViewController) {
            keyController = keyController.presentedViewController;
        }else{
            break;
        }
    }while(keyController.presentedViewController);
    return keyController;
}

+ (UIWindow *)appWindow{
    AppDelegate * delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    UIWindow * window = delegate.window;
    return window;
}

@end
