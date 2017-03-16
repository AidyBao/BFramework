//
//  MQFontConfig.h
//  MQStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MQFontConfig : NSObject

+ (NSString *)titleFontName;
+ (NSString *)bodyFontName;
+ (NSString *)customAFontName;
+ (NSString *)customBFontName;
+ (NSString *)iconFontName;
+ (CGFloat)title1FontSize;
+ (CGFloat)title2FontSize;
+ (CGFloat)bodyFontSize;
+ (NSString *)textColor;
+ (NSString *)sub1TextColor;
+ (NSString *)sub2TextColor;

@end
