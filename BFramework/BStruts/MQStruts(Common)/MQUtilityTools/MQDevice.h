//
//  MQDevice.h
//  YDGJ
//
//  Created by 120v on 2017/2/8.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQDevice : NSObject

#pragma mark - 设备信息
/**获取手机UUID**/
+(NSString *)MQ_DeviceUUID;
/**获取手机系统版本**/
+(NSString *)MQ_DeviceVersion;
/** 手机系统 */
+(NSString *)MQ_DeviceSystem;
/** 手机类型 */
+(NSString *)MQ_DeviceType;

@end
