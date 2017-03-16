//
//  NSBundle+ZXSetting.h
//  ZXStructure
//
//  JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSBundle (MQSetting)

/*!
 获取ZXSetting Bundle
 */
+ (instancetype)mq_settingBundle;

/*!
 获取 按钮 配置文件路径
 */
+ (NSString *)pathForButtonConfig;

/*!
 获取 字体 配置
 */
+ (NSString *)pathForFontConfig;

/*!
 获取 NavgationBar 配置文件路径
 */
+ (NSString *)pathForNavBarConfig;

/*!
 获取 Tabbar 配置文件路径
 */
+ (NSString *)pathForTabBarConfig;

/*!
 获取 程序主色调 配置文件路径
 */
+ (NSString *)pathForTintColorConfig;

/**从ZXSetting 获取导航栏返回图片*/
+ (UIImage *)mq_navBackImage;

@end
