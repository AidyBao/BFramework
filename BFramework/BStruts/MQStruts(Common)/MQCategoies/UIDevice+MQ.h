//
//  UIDevice+MQ.h
//  MQStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MQ_IOS7_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] != NSOrderedAscending)
#define MQ_IOS8_OR_LATER   ([[[UIDevice currentDevice] systemVersion] compare:@"8.0" options:NSNumericSearch] != NSOrderedAscending)
#define MQ_IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define MQ_IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define MQ_BOUNDS_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define MQ_BOUNDS_HEIGHT ([[UIScreen mainScreen] bounds].size.height)


typedef enum : NSUInteger {
    MQ_IPHONE4,/**3.5及以下英寸*/
    MQ_IPHONE5,/**4.0英寸 (5 5S 5SE)*/
    MQ_IPHONE6,/**4.7英寸 (6 6S 7)*/
    MQ_IPHONE6P,/**5.5英寸 (6P 6SP 7P)*/
    MQ_IPAD/**iPad 尺寸*/
} MQ_DeviceSizeType;


@interface UIDevice (MQ)

/**设备尺寸类型*/
+ (MQ_DeviceSizeType)mq_deviceSizeType;

@end
