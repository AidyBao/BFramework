//
//  NSAttributedString+ZX.h
//  ZXStructure
//
//  JuanFelix on 26/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    MQUnderLine,//下划线
    MQDeleteLine//删除线
} MQAttributeStringLineType;

@interface NSAttributedString (MQ)

/**文字添加删除线 或下划线*/
+ (NSMutableAttributedString *)mq_addLineToText:(NSString *)text
                                           type:(MQAttributeStringLineType)type
                                        atRange:(NSRange)range;
/**修改字符串 某段文字颜色*/
+ (NSMutableAttributedString *)mq_addColorToText:(NSString *)text
                                       withColor:(UIColor *)color
                                         atRange:(NSRange)range;

/**修改字符串 某段文字字体 可以为空*/
+ (NSMutableAttributedString *)mq_addFontToText:(NSString *)text
                                       withFont:(UIFont *)font
                                        atRange:(NSRange)range;


@end
