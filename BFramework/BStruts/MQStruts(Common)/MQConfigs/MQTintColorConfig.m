//
//  MQTintColorConfig.m
//  MQStructure
//
//  JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "MQTintColorConfig.h"
#import "NSBundle+MQSetting.h"

static NSDictionary * mqTintColorConfig = nil;

@implementation MQTintColorConfig
+ (void)initialize{
    mqTintColorConfig = [self loadConfig];
}



+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForTintColorConfig]];
}

+ (NSString *)mainColor{
    if (mqTintColorConfig) {
        NSString * color = mqTintColorConfig[@"mq_tintColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3b87ef";
}

+ (NSString *)assistColor{
    if (mqTintColorConfig) {
        NSString * color = mqTintColorConfig[@"mq_assistColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#eff7fd";
}

+ (NSString *)backgroundColor{
    if (mqTintColorConfig) {
        NSString * color = mqTintColorConfig[@"mq_backgroundColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)separatorColor{
    if (mqTintColorConfig) {
        NSString * color = mqTintColorConfig[@"mq_separatorColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#eaeef4";
}

+ (NSString *)borderColor{
    if (mqTintColorConfig) {
        NSString * color = mqTintColorConfig[@"mq_borderColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)customAColor{
    if (mqTintColorConfig) {
        NSString * color = mqTintColorConfig[@"mq_customAColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#f29252";
}

+ (NSString *)customBColor{
    if (mqTintColorConfig) {
        NSString * color = mqTintColorConfig[@"mq_customBColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ff4221";
}

+ (NSString *)customCColor{
    if (mqTintColorConfig) {
        NSString * color = mqTintColorConfig[@"mq_customCColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ff4200";
}

@end
