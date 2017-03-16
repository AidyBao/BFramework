//
//  MQTabBarConfig.m
//  MQStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQTabBarConfig.h"
#import "NSBundle+MQSetting.h"
#import "MQFontSize.h"

static NSDictionary * mqTabBarConfig = nil;


@implementation MQTabBarConfig

+ (void)initialize{
    mqTabBarConfig = [self loadConfig];
}

+ (NSDictionary *)loadConfig{
    return [NSDictionary dictionaryWithContentsOfFile:[NSBundle pathForTabBarConfig]];
}

+ (BOOL)showSeparatorLine{
    if (mqTabBarConfig) {
        return [mqTabBarConfig[@"mq_showSeparatorLine"] boolValue];
    }
    return true;
}

+ (BOOL)isTranslucent{
    if (mqTabBarConfig) {
        return [mqTabBarConfig[@"mq_isTranslucent"] boolValue];
    }
    return true;
}

+ (NSString *)backgroundColor{
    if (mqTabBarConfig) {
        NSString * color = mqTabBarConfig[@"mq_backgroundColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#ffffff";
}

+ (NSString *)textNormalColor{
    if (mqTabBarConfig) {
        NSString * color = mqTabBarConfig[@"mq_textNomalColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#afaaae";
}

+ (NSString *)textSelectedColor{
    if (mqTabBarConfig) {
        NSString * color = mqTabBarConfig[@"mq_textSelectedColor"];
        if (color && [color respondsToSelector:@selector(length)]) {
            return color;
        }
    }
    return @"#3b87ef";
}


+ (BOOL)isCustomFontSize{
    if (mqTabBarConfig) {
        return [mqTabBarConfig[@"mq_customFontSize"] boolValue];
    }
    return true;
}

+ (CGFloat)titleFontSize{
    if (mqTabBarConfig) {
        return [MQFontSize fontSizeWithDic:mqTabBarConfig[@"mq_titleFontSize"] defaultSize:10];
    }
    return 10;
}

+ (NSArray<MQTabbarItem *> *)tabbarItems{
    NSMutableArray * arrItems = [NSMutableArray array];
    if (mqTabBarConfig) {
        NSArray * tempA = mqTabBarConfig[@"mq_items"];
        if (tempA) {
            for (NSDictionary * dicT in tempA) {
                MQTabbarItem * item = [[MQTabbarItem alloc] init];
                [item setValuesForKeysWithDictionary:dicT];
                [arrItems addObject:item];
            }
        }
    }
    return arrItems;
}



@end
