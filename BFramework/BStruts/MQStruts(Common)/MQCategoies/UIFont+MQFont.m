//
//  UIFont+ZXFont.m
//  ZXStructure
//
//  JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UIFont+MQFont.h"
#import "MQNavBarConfig.h"
#import "MQTabBarConfig.h"
#import "MQFontConfig.h"
#import "MQButtonConfig.h"

//MARK: - 字体大小

//MARK: -- 标题1
CGFloat mq_title1FontSize() {
    return [MQFontConfig title1FontSize];
}
//MARK: -- 标题1
CGFloat mq_title2FontSize() {
    return [MQFontConfig title2FontSize];
}
//MARK: -- 正文
CGFloat mq_bodyFontSize() {
    return [MQFontConfig bodyFontSize];
}

//MARK: -- 导航栏

CGFloat mq_navBarTitleFontSize() {
    return [MQNavBarConfig titleFontSize];
}

CGFloat mq_navBarButtonTitleFontSize() {
    return [MQNavBarConfig buttonFontSize];
}

//MARK: -- 标签栏

CGFloat mq_tabBarItemTitleFontSize() {
    return [MQTabBarConfig titleFontSize];
}

//MARK: -- 通用按钮


CGFloat mq_buttonTitleFontSize() {
    return [MQButtonConfig titleFontSize];
}

@implementation UIFont (MQFont)


//MARK: - 字体名称相关

+ (UIFont *)mq_titleFontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[MQFontConfig titleFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)mq_bodyFontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[MQFontConfig bodyFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)mq_customAFontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[MQFontConfig customAFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)mq_customBFontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[MQFontConfig customBFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}

+ (UIFont *)mq_iconfontWithSize:(CGFloat)fontSize{
    UIFont * font = [UIFont fontWithName:[MQFontConfig iconFontName] size:fontSize];
    if (font) {
        return font;
    }
    return [UIFont systemFontOfSize:fontSize];
}


//MARK: - 字号名称相关



@end
