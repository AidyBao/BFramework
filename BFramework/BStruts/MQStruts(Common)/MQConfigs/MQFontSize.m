//
//  MQFontSize.m
//  MQStructure
//
//  JuanFelix on 2016/11/24.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQFontSize.h"
#import "UIDevice+MQ.h"

@implementation MQFontSize

+ (CGFloat)fontSizeWithDic:(NSDictionary *)dicP defaultSize:(CGFloat)dSize{
    if ([dicP isKindOfClass:[NSDictionary class]]) {
        switch ([UIDevice mq_deviceSizeType]) {
            case MQ_IPHONE4:
            case MQ_IPHONE5:
            {
                return [dicP[@"iPhone5"] floatValue];
            }
                break;
            case MQ_IPHONE6:
            {
                return [dicP[@"iPhone6"] floatValue];
            }
                break;
            case MQ_IPHONE6P:
            case MQ_IPAD:
            {
                return [dicP[@"iPhone6P"] floatValue];
            }
                break;
            default:
                break;
        }
    }
    return dSize;
}

@end
