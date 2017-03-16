//
//  UIDevice+MQ.m
//  MQStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "UIDevice+MQ.h"

#define MQ_SCREEN_MAX_LENGTH    (MAX(MQ_BOUNDS_WIDTH, MQ_BOUNDS_HEIGHT))
#define MQ_SCREEN_MIN_LENGTH    (MIN(MQ_BOUNDS_WIDTH, MQ_BOUNDS_HEIGHT))
#define MQ_IS_IPHONE_4_OR_LESS  (MQ_IS_IPHONE && MQ_SCREEN_MAX_LENGTH < 568.0)
#define MQ_IS_IPHONE_5          (MQ_IS_IPHONE && MQ_SCREEN_MAX_LENGTH == 568.0)
#define MQ_IS_IPHONE_6          (MQ_IS_IPHONE && MQ_SCREEN_MAX_LENGTH == 667.0)
#define MQ_IS_IPHONE_6P         (MQ_IS_IPHONE && MQ_SCREEN_MAX_LENGTH == 736.0)
#define MQ_IS_IPHONE_IPAD       (MQ_IS_IPHONE && MQ_SCREEN_MAX_LENGTH >= 1024)


@implementation UIDevice (MQ)

+ (MQ_DeviceSizeType)mq_deviceSizeType{
    if (MQ_IS_IPHONE_4_OR_LESS) {
        return MQ_IPHONE4;
    }
    if (MQ_IS_IPHONE_5) {
        return MQ_IPHONE5;
    }
    if (MQ_IS_IPHONE_6) {
        return MQ_IPHONE6;
    }
    if (MQ_IS_IPHONE_6P) {
        return MQ_IPHONE6P;
    }
    if (MQ_IS_IPHONE_IPAD) {
        return MQ_IPAD;
    }
    return MQ_IPHONE5;
}

@end
