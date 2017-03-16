//
//  NSAttributedString+ZX.m
//  ZXStructure
//
//  JuanFelix on 26/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "NSAttributedString+MQ.h"

@implementation NSAttributedString (MQ)

+ (NSMutableAttributedString *)mq_addLineToText:(NSString *)text
                                           type:(MQAttributeStringLineType)type
                                        atRange:(NSRange)range{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:text];
    switch (type) {
        case MQDeleteLine:
        {
            [attrString addAttribute:NSStrikethroughStyleAttributeName
                               value:@(NSUnderlinePatternSolid | NSUnderlineStyleSingle)
                               range:range];
        }
            break;
        case MQUnderLine:
        {
            [attrString addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:range];
        }
            break;
        default:
        {
            [attrString addAttribute:NSUnderlineStyleAttributeName
                               value:@(NSUnderlineStyleSingle)
                               range:range];
        }
            break;
    }
    return attrString;
}

+ (NSMutableAttributedString *)mq_addColorToText:(NSString *)text
                                       withColor:(UIColor *)color
                                         atRange:(NSRange)range{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:text];
    if (range.length) {
        [attrString addAttribute:NSForegroundColorAttributeName value:color range:range];
    }
    return attrString;
}

+ (NSMutableAttributedString *)mq_addFontToText:(NSString *)text
                                       withFont:(UIFont *)font
                                        atRange:(NSRange)range{
    NSMutableAttributedString * attrString = [[NSMutableAttributedString alloc] initWithString:text];
    if (range.length) {
        [attrString addAttribute:NSFontAttributeName value:font range:range];
    }
    return attrString;
}


@end
