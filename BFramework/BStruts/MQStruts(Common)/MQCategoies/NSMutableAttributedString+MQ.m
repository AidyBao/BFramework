//
//  NSMutableAttributedString+ZX.m
//  ZXStructure
//
//  JuanFelix on 26/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "NSMutableAttributedString+MQ.h"

@implementation NSMutableAttributedString (MQ)

- (NSMutableAttributedString *)mq_appendColor:(UIColor *)color
                                      atRange:(NSRange)range{
    [self addAttribute:NSForegroundColorAttributeName value:color range:range];
    return self;
}

- (NSMutableAttributedString *)mq_appendFont:(UIFont *)font
                                     atRange:(NSRange)range{
    [self addAttribute:NSFontAttributeName value:font range:range];
    return self;
}

@end
