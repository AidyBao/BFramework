//
//  UILabel+ZXAnimation.m
//  YDGJ
//
//  Created by screson on 2017/2/14.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "UILabel+MQAnimation.h"

@implementation UILabel (MQAnimation)

- (void)mq_setFromNumber:(double)fNum1
                finalNum:(double)fNum2
                interval:(NSTimeInterval)interval
                   speed:(int)count
                intValue:(BOOL)intValue{
    if (count <= 0 || fNum1 >= fNum2) {
        NSString *currencyStr = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithDouble:fNum2]  numberStyle:NSNumberFormatterCurrencyStyle];
        currencyStr = [currencyStr substringWithRange:NSMakeRange(1, currencyStr.length-1)];
        if (intValue) {
            currencyStr = [[currencyStr componentsSeparatedByString:@"."] firstObject];
        }
        self.text = currencyStr;
        return;
    }
    float dt  = fNum2 / 100;
    NSString *currencyStr = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithDouble:fNum1]  numberStyle:NSNumberFormatterCurrencyStyle];
    currencyStr = [currencyStr substringWithRange:NSMakeRange(1, currencyStr.length-1)];
    if (intValue) {
        currencyStr = [[currencyStr componentsSeparatedByString:@"."] firstObject];
    }
    self.text = currencyStr;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(interval * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self mq_setFromNumber:fNum1 + dt finalNum:fNum2 interval:interval speed:count intValue:intValue];
    });
//    [UIView animateWithDuration:interval delay:0 options:UIViewAnimationOptionTransitionNone animations:^{
//        NSString *currencyStr = [NSNumberFormatter localizedStringFromNumber:[NSNumber numberWithDouble:fNum1]  numberStyle:NSNumberFormatterCurrencyStyle];
//        currencyStr = [currencyStr substringWithRange:NSMakeRange(1, currencyStr.length-1)];
//        if (intValue) {
//            currencyStr = [[currencyStr componentsSeparatedByString:@"."] firstObject];
//        }
//        self.text = currencyStr;
//    } completion:^(BOOL finished) {
//        [self zx_setFromNumber:fNum1 + dt finalNum:fNum2 interval:interval speed:count intValue:intValue];
//    }];
}

@end
