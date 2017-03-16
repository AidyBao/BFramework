//
//  UIFont+MQFont.h
//  MQStructure
//
//  JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

//MARK: -- 正文
/**标题1 字体大小 默认 6:17号*/
extern CGFloat mq_title1FontSize();
/**标题2 字体大小 默认 6:15号*/
extern CGFloat mq_title2FontSize();
/*!正文 字体大小 默认 6:14号*/
extern CGFloat mq_bodyFontSize();

//MARK: -- 导航栏
/**导航栏 Title文字大小 默认 6:21号*/
extern CGFloat mq_navBarTitleFontSize();
/**导航栏 按钮文字大小 默认 6:18号*/
extern CGFloat mq_navBarButtonTitleFontSize();

//MARK: -- 标签栏
/**标签栏 按钮文字大小 默认 系统字号*/
extern CGFloat mq_tabBarItemTitleFontSize();

//MARK: -- 通用按钮

/**字体名称 字号*/
@interface UIFont (MQFont)

//MARK: -- 通用按钮字号
/**通用按钮 字号*/
extern CGFloat mq_buttonTitleFontSize();

//MARK: - 字体构造

/** 返回标题字体 (不存在时返回系统默认字体)*/
+ (UIFont *)mq_titleFontWithSize:(CGFloat)fontSize;

/** 返回正文字体 (不存在时返回系统默认字体)*/
+ (UIFont *)mq_bodyFontWithSize:(CGFloat)fontSize;

/** 返回自定义字体A (不存在时返回系统默认字体)*/
+ (UIFont *)mq_customAFontWithSize:(CGFloat)fontSize;

/** 返回自定义字体B (不存在时返回系统默认字体)*/
+ (UIFont *)mq_customBFontWithSize:(CGFloat)fontSize;

/** 返回iconfont 图标字体 (不存在时返回系统默认字体)*/
+ (UIFont *)mq_iconfontWithSize:(CGFloat)fontSize;


@end
