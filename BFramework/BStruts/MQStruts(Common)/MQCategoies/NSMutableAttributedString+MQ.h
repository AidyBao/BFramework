//
//  NSMutableAttributedString+ZX.h
//  ZXStructure
//
//  JuanFelix on 26/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSMutableAttributedString (MQ)

/**追加颜色样式设置*/
- (NSMutableAttributedString *)mq_appendColor:(UIColor *)color
                                      atRange:(NSRange)range;
/**追加字体样式设置*/
- (NSMutableAttributedString *)mq_appendFont:(UIFont *)font
                                     atRange:(NSRange)range;

@end
