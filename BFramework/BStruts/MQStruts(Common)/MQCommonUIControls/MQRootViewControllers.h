//
//  MQRootViewControllers.h
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**管理程序主控制器*/
@interface MQRootViewControllers : NSObject

/**
 @program 主页 Tabbar控制器
 **/
+ (UITabBarController *)mq_tabbarController;
+ (void)loadfromPlistWithControllerClassNames:(NSArray<NSString *> *)classNames;
+ (void)reloadfromPlistWithControllerClassNames:(NSArray<NSString *> *)classNames;

/**
 @program Window
 **/
+ (UIWindow *)appWindow;

/**
@program 获取根视图
 **/
+ (UIViewController *)keyController;

/**
 @program 装载控制器
 **/
+ (void)reload;

@end
