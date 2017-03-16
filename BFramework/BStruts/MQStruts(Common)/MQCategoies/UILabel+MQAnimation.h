//
//  UILabel+ZXAnimation.h
//  YDGJ
//
//  Created by screson on 2017/2/14.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (MQAnimation)

- (void)mq_setFromNumber:(double)fNum1
                finalNum:(double)fNum2
                interval:(NSTimeInterval)interval
                   speed:(int)count
                intValue:(BOOL)intValue;

@end
