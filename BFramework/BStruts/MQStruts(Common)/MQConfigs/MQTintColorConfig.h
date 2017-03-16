//
//  MQTintColorConfig.h
//  MQStructure
//
//  JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQTintColorConfig : NSObject

+ (NSDictionary *)loadConfig;

/** 程序主色调*/
+ (NSString *)mainColor;
/** 程序辅助色*/
+ (NSString *)assistColor;
/** 背景色*/
+ (NSString *)backgroundColor;
/** 分割线颜色*/
+ (NSString *)separatorColor;
/** 边框颜色*/
+ (NSString *)borderColor;
/** 自定义颜色A*/
+ (NSString *)customAColor;
/** 自定义颜色B*/
+ (NSString *)customBColor;
/** 自定义颜色C*/
+ (NSString *)customCColor;

@end
