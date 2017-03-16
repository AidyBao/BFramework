//
//  APPManager.h
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserLoginModel.h"

@interface APPManager : NSObject


#pragma mark - 单列
#pragma mark 获取单例
+(id)shareManager;
#pragma mark 获取LoginBaseUser实例方法
-(UserLoginModel *)loginModel;


#pragma mark - 保存
#pragma mark 保存登录信息
- (void)saveUserLoginWithDict:(NSDictionary *)dict;
#pragma mark 保存登录状态
- (void)saveLoginSataus;
#pragma mark 更新名字
- (void)updateName;
#pragma mark 修改电话号码
- (void)updateTelphoneNumber;
#pragma mark 修改密码
- (void)updatePassword;
#pragma mark 修改头像
- (void)updateHeadPortraitStr;
#pragma mark 保存明文密码
+ (void)saveLocationPassword:(NSString *)passWord;
#pragma mark 消息推送Token
+ (void)saveNoticeDeviceToken:(NSString *)deviceToken;

#pragma mark - 获取
#pragma mark 获取登录状态
+ (BOOL)getIsLoginSataus;
#pragma mark 获取明文密码
+ (NSString *)getLocationPassword;
#pragma mark 获取消息推送Token
+ (NSString *)getNoticeDeviceToken;
#pragma mark 获取deviceToken
+ (NSString *)getDeviceToken;
#pragma mark 获取failedTimes
+ (NSString *)getFailedTimes;
#pragma mark 获取headPortrait
+ (NSString *)getHeadPortrait;
#pragma mark 获取headPortraitStr
+ (NSString *)getheadPortraitStr;
#pragma mark 获取uid
+ (NSString *)getUID;
#pragma mark 获取loginTime
+ (NSString *)getLoginTime;
#pragma mark 获取mobileModel
+ (NSString *)getMobileModel;
#pragma mark 获取mobileSystemType
+ (NSString *)getMobileSystemType;
#pragma mark 获取mobileSystemVersion
+ (NSString *)getMobileSystemVersion;
#pragma mark 获取name
+ (NSString *)getName;
#pragma mark 获取operationDate
+ (NSString *)getOperationDate;
#pragma mark 获取operatorId
+ (NSString *)getOperatorId;
#pragma mark 获取operatorName
+ (NSString *)getOperatorName;
#pragma mark 获取passWord
+ (NSString *)getPassWord;
#pragma mark 获取position
+ (NSString *)getPosition;
#pragma mark 获取qrCode
+ (NSString *)getQrCode;
#pragma mark 获取remark
+ (NSString *)getRemark;
#pragma mark 获取status
+ (NSString *)getStatus;
#pragma mark 获取tel
+ (NSString *)getTel;
#pragma mark 获取token
+ (NSString *)getToken;
#pragma mark 获取userName
+ (NSString *)getUserName;
#pragma mark 获取uuid
+ (NSString *)getUUID;


#pragma mark - 清空用户信息
-(void)cleanAll;

@end

