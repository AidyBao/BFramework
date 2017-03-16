//
//  NSBundle+ZXSetting.m
//  ZXStructure
//
//  JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "NSBundle+MQSetting.h"
#import "MQCommonEngine.h"

@implementation NSBundle (MQSetting)

+ (instancetype)mq_settingBundle{
    static NSBundle * settingBundle = nil;
    if (settingBundle == nil) {
        settingBundle = [NSBundle bundleWithPath:[[NSBundle bundleForClass:[MQCommonEngine class]] pathForResource:@"MQSettings" ofType:@"bundle"]];
    }
    return settingBundle;
}

+ (NSString *)pathForButtonConfig{
    return [[self mq_settingBundle]  pathForResource:@"UIConfig/MQButtonConfig" ofType:@"plist"];
}

+ (NSString *)pathForFontConfig{
    return [[self mq_settingBundle]  pathForResource:@"UIConfig/MQFontConfig" ofType:@"plist"];
}

+ (NSString *)pathForNavBarConfig{
    return [[self mq_settingBundle]  pathForResource:@"UIConfig/MQNavBarConfig" ofType:@"plist"];
}

+ (NSString *)pathForTabBarConfig{
    return [[self mq_settingBundle]  pathForResource:@"UIConfig/MQTabBarConfig" ofType:@"plist"];
}

+ (NSString *)pathForTintColorConfig{
    return [[self mq_settingBundle]  pathForResource:@"UIConfig/MQTintColorConfig" ofType:@"plist"];
}

+ (UIImage *)mq_navBackImage{
    static UIImage * navBackImage = nil;
    if (!navBackImage) {
        navBackImage = [UIImage imageWithContentsOfFile:[[self mq_settingBundle] pathForResource:@"mq_navback" ofType:@"png"]];
    }
    return navBackImage;
}

@end
