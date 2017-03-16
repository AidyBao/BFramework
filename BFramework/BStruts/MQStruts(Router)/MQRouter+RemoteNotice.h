//
//  MQRouter+RemoteNotice.h
//  MQStructure
//
//  JuanFelix on 2016/11/25.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQRouter.h"

typedef enum : NSUInteger {
    MQRemoteNoticeTypeNewNotice,
    MQRemoteNoticeTypeOrderUpdate,
    MQRemoteNoticeTypeTakeUnknown
} MQRemoteNoticeType;

@interface ApsModel : NSObject

@property (nonatomic,strong) NSString * alert;
@property (nonatomic,strong) NSNumber * sound;

@end

@interface MQRemoteNoticeModel : NSObject

@property (nonatomic,strong) ApsModel * aps;
@property (nonatomic,strong) NSString * d;
@property (nonatomic,strong) NSString * pushType;  //文本
@property (nonatomic,strong) NSString * p;//提醒时间


//调整
@property (nonatomic,assign) MQRemoteNoticeType type;
@property (nonatomic,assign) BOOL fromUserTap;

@end

/** 远程通知 界面跳转控制 */
@interface MQRouter (RemoteNotice)


+ (void)showNoticeDetail:(NSDictionary *)userInfo;

+ (void)checkNoticeCache;

@end
