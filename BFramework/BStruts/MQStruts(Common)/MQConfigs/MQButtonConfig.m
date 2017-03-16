//
//  MQButtonConfig.m
//  MQStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQButtonConfig.h"
#import <UIKit/UIKit.h>
#import "NSBundle+MQSetting.h"
#import "MQFontSize.h"

static NSDictionary * mqButtongConfig = nil;

@implementation MQButtonConfig

+ (void)initialize{
    [self loadConfig];
}

+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForButtonConfig]];
}

+ (NSString *)backgroundNormalColor{
    if (mqButtongConfig) {
        NSString * color = mqButtongConfig[@"mq_backgroundNormalColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3b87ef";
}

+ (NSString *)backgroundSelectedColor{
    if (mqButtongConfig) {
        NSString * color = mqButtongConfig[@"mq_backgroundSelectedColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#2773da";
}


+ (NSString *)backgroundDisabledColor{
    if (mqButtongConfig) {
        NSString * color = mqButtongConfig[@"mq_backgroundDisabledColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#b8d6ff";
}

+ (NSString *)titleNormalColor{
    if (mqButtongConfig) {
        NSString * color = mqButtongConfig[@"mq_titleNormalColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)titleSelectedColor{
    if (mqButtongConfig) {
        NSString * color = mqButtongConfig[@"mq_titleSelectedColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}


+ (NSString *)titleDisabledColor{
    if (mqButtongConfig) {
        NSString * color = mqButtongConfig[@"mq_titleDisabledColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (CGFloat)titleFontSize{
    if (mqButtongConfig) {
        return [MQFontSize fontSizeWithDic:mqButtongConfig[@"mq_titleFontSize"] defaultSize:18];
    }
    return 18;
}

@end
