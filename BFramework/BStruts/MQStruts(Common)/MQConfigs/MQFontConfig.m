//
//  MQFontConfig.m
//  MQStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQFontConfig.h"
#import "NSBundle+MQSetting.h"
#import "MQFontSize.h"

static NSDictionary * mqFontConfig = nil;

@implementation MQFontConfig

+ (void)initialize{
    mqFontConfig = [self loadConfig];
}

+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForFontConfig]];
}


+ (NSString *)titleFontName{
    return mqFontConfig[@"mq_tilteFontName"];
}

+ (NSString *)bodyFontName{
    return mqFontConfig[@"mq_bodyFontName"];
}

+ (NSString *)customAFontName{
    return mqFontConfig[@"mq_customAFontName"];
}

+ (NSString *)customBFontName{
    return mqFontConfig[@"mq_customBFontName"];
}

+ (NSString *)iconFontName{
    return mqFontConfig[@"mq_iconfontName"];
}


+ (CGFloat)title1FontSize{
    if (mqFontConfig) {
        return [MQFontSize fontSizeWithDic:mqFontConfig[@"mq_title1FontSize"] defaultSize:17];
    }
    return 17;
}

+ (CGFloat)title2FontSize{
    if (mqFontConfig) {
        return [MQFontSize fontSizeWithDic:mqFontConfig[@"mq_title2FontSize"] defaultSize:15];
    }
    return 15;
}

+ (CGFloat)bodyFontSize{
    if (mqFontConfig) {
        return [MQFontSize fontSizeWithDic:mqFontConfig[@"mq_bodyFontSize"] defaultSize:14];
    }
    return 14;
}

+ (NSString *)textColor{
    if (mqFontConfig) {
        NSString * color = mqFontConfig[@"mq_textColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3b3e43";
}

+ (NSString *)sub1TextColor{
    if (mqFontConfig) {
        NSString * color = mqFontConfig[@"mq_sub1TextColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#5e6269";

}

+ (NSString *)sub2TextColor{
    if (mqFontConfig) {
        NSString * color = mqFontConfig[@"mq_sub2TextColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#9fa4ac";
}

@end
