//
//  UIColor+MQColor.m
//  MQStructure
//
//  JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "UIColor+MQColor.h"
#import "MQTintColorConfig.h"
#import "MQNavBarConfig.h"
#import "MQTabBarConfig.h"
#import "MQFontConfig.h"
#import "MQButtonConfig.h"

@implementation UIColor (MQColor)

//MARK: -
+ (UIColor *)mq_colorWithHEX:(long)hex
                       alpha:(CGFloat)opacity{
    float red = ((float)((hex & 0xFF0000) >> 16))/255.0;
    float green = ((float)((hex & 0xFF00) >> 8))/255.0;
    float blue = ((float)(hex & 0xFF))/255.0;
    return [UIColor colorWithRed:red green:green blue:blue alpha:opacity];
}

+ (UIColor *)mq_colorWithHEX:(long)hex{
    return [self mq_colorWithHEX:hex alpha:1.0];
}

+ (UIColor *)mq_colorWithHEXString:(NSString *)color
                             alpha:(CGFloat)alpha
{
    //删除字符串中的空格
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    // String should be 6 or 8 characters
    if ([cString length] < 6)
    {
        return [UIColor clearColor];
    }
    // strip 0X if it appears
    //如果是0x开头的，那么截取字符串，字符串从索引为2的位置开始，一直到末尾
    if ([cString hasPrefix:@"0X"])
    {
        cString = [cString substringFromIndex:2];
    }
    //如果是#开头的，那么截取字符串，字符串从索引为1的位置开始，一直到末尾
    if ([cString hasPrefix:@"#"])
    {
        cString = [cString substringFromIndex:1];
    }
    if ([cString length] != 6)
    {
        return [UIColor clearColor];
    }
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    //r
    NSString *rString = [cString substringWithRange:range];
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    return [UIColor colorWithRed:((float)r / 255.0f) green:((float)g / 255.0f) blue:((float)b / 255.0f) alpha:alpha];
}


//MARK: - MAIN COLOR
+ (UIColor *)mq_tintColor{
    return [self mq_colorWithHEXString:[MQTintColorConfig mainColor] alpha:1.0];
}

+ (UIColor *)mq_assistColor{
    return [self mq_colorWithHEXString:[MQTintColorConfig assistColor] alpha:1.0];
}

+ (UIColor *)mq_backgroundColor{
    return [self mq_colorWithHEXString:[MQTintColorConfig backgroundColor] alpha:1.0];
}

+ (UIColor *)mq_separatorColor{
    return [self mq_colorWithHEXString:[MQTintColorConfig separatorColor] alpha:1.0];
}

+ (UIColor *)mq_borderColor{
    return [self mq_colorWithHEXString:[MQTintColorConfig borderColor] alpha:1.0];
}

+ (UIColor *)mq_customAColor{
    return [self mq_colorWithHEXString:[MQTintColorConfig customAColor] alpha:1.0];
}

+ (UIColor *)mq_customBColor{
    return [self mq_colorWithHEXString:[MQTintColorConfig customBColor] alpha:1.0];
}

+ (UIColor *)mq_customCColor{
    return [self mq_colorWithHEXString:[MQTintColorConfig customCColor] alpha:1.0];
}

//MARK: - 导航栏色调
+ (UIColor *)mq_navbarColor{
    return [self mq_colorWithHEXString:[MQNavBarConfig backgroundColor] alpha:1.0];
}

+ (UIColor *)mq_navbarTitleColor{
    return [self mq_colorWithHEXString:[MQNavBarConfig textColor] alpha:1.0];
}

+ (UIColor *)mq_navbarButtonTitleColor{
    return [self mq_colorWithHEXString:[MQNavBarConfig buttonColor] alpha:1.0];
}


//MARK: - 标签栏色调
+ (UIColor *)mq_tabbarColor{
    return [self mq_colorWithHEXString:[MQTabBarConfig backgroundColor] alpha:1.0];
}

+ (UIColor *)mq_tabbarTitleNormalColor{
    return [self mq_colorWithHEXString:[MQTabBarConfig textNormalColor] alpha:1.0];
}

+ (UIColor *)mq_tabbarTitleSelectedColor{
    return [self mq_colorWithHEXString:[MQTabBarConfig textSelectedColor] alpha:1.0];
}

//MARK: - 字体色调

+ (UIColor *)mq_textColor{
     return [self mq_colorWithHEXString:[MQFontConfig textColor] alpha:1.0];
}

+ (UIColor *)mq_sub1TextColor{
    return [self mq_colorWithHEXString:[MQFontConfig sub1TextColor] alpha:1.0];
}

+ (UIColor *)mq_sub2TextColor{
    return [self mq_colorWithHEXString:[MQFontConfig sub2TextColor] alpha:1.0];
}

//MARK: - 按钮色调

+ (UIColor *)mq_buttonBGNormalColor{
    return [self mq_colorWithHEXString:[MQButtonConfig backgroundNormalColor] alpha:1.0];
}

+ (UIColor *)mq_buttonBGSelectedColor{
    return [self mq_colorWithHEXString:[MQButtonConfig backgroundSelectedColor] alpha:1.0];
}


+ (UIColor *)mq_buttonBGDisabledColor{
    return [self mq_colorWithHEXString:[MQButtonConfig backgroundDisabledColor] alpha:1.0];
}


+ (UIColor *)mq_buttonTitleNormalColor{
    return [self mq_colorWithHEXString:[MQButtonConfig titleNormalColor] alpha:1.0];
}


+ (UIColor *)mq_buttonTitleSelectedColor{
    return [self mq_colorWithHEXString:[MQButtonConfig titleSelectedColor] alpha:1.0];
}


+ (UIColor *)mq_buttonTitleDisabledColor{
    return [self mq_colorWithHEXString:[MQButtonConfig titleDisabledColor] alpha:1.0];
}




@end
