//
//  MQNavBarConfig.m
//  MQStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQNavBarConfig.h"
#import "NSBundle+MQSetting.h"
#import "MQFontSize.h"

static NSDictionary * mqNavBarConfig = nil;

@implementation MQNavBarConfig

+ (void)initialize{
    mqNavBarConfig = [self loadConfig];
}

+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForNavBarConfig]];
}

+ (BOOL)userSystemBackButton{
    if (mqNavBarConfig) {
        return [mqNavBarConfig[@"mq_useSystemBackButton"] boolValue];
    }
    return true;
}

+ (BOOL)showSeparatorLine{
    if (mqNavBarConfig) {
        return [mqNavBarConfig[@"mq_showSeparatorLine"] boolValue];
    }
    return true;
}

+ (BOOL)isTranslucent{
    if (mqNavBarConfig) {
        return [mqNavBarConfig[@"mq_isTranslucent"] boolValue];
    }
    return true;
}

+ (NSString *)backgroundColor{
    if (mqNavBarConfig) {
        NSString * color = mqNavBarConfig[@"mq_backgroundColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3B87EE";
}

+ (NSString *)textColor{
    if (mqNavBarConfig) {
        NSString * color = mqNavBarConfig[@"mq_textColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)buttonColor{
    if (mqNavBarConfig) {
        NSString * color = mqNavBarConfig[@"mq_buttonColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (CGFloat)titleFontSize{
    if (mqNavBarConfig) {
        return [MQFontSize fontSizeWithDic:mqNavBarConfig[@"mq_titleFontSize"] defaultSize:18];
    }
    return 18;
}

+ (CGFloat)buttonFontSize{
    if (mqNavBarConfig) {
        return [MQFontSize fontSizeWithDic:mqNavBarConfig[@"mq_buttonFontSize"] defaultSize:14];
    }
    return 14;
}

@end
