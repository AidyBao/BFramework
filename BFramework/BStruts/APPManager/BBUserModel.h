//
//  BBUserModel.h
//  BFramework
//
//  Created by 120v on 2020/5/21.
//  Copyright © 2020 120v. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface BBUserModel : NSObject

@property (nonatomic, copy) NSString *appVersion;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *failedTimes;
@property (nonatomic, copy) NSString *headPortrait;
@property (nonatomic, copy) NSString *headPortraitStr;
@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *loginTime;
@property (nonatomic, copy) NSString *mobileModel;
@property (nonatomic, copy) NSString *mobileSystemType;
@property (nonatomic, copy) NSString *mobileSystemVersion;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *operationDate;
@property (nonatomic, copy) NSString *operatorId;
@property (nonatomic, copy) NSString *operatorName;
@property (nonatomic, copy) NSString *packageName;
@property (nonatomic, copy) NSString *passWord;
@property (nonatomic, copy) NSString *position;
@property (nonatomic, copy) NSString *recommenderCount;
@property (nonatomic, copy) NSString *qrCode;
@property (nonatomic, copy) NSString *remark;
@property (nonatomic, copy) NSString *status;
@property (nonatomic, copy) NSString *tel;
@property (nonatomic, copy) NSString *token;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *uuid;

/** 登录状态*/
@property (nonatomic, assign) BOOL isLoginSataus;

/**
* 单例初始化
*/
+(instancetype)share;

/**
 * 重置单例
 */
+ (void)resetUserModel;

/**
 * 清除本地的所有用户数据
 */
+ (void)clearLocalUserModel;

/**
 更新本地的用户数据
 @param user 传入用户模型
 */
+ (void)updateLocalUserModel:(BBUserModel *)user;

/**
 * 加载本地的用户模型
 */
+ (BBUserModel *)loadLocalUserModel;

/**
* 文件夹大小的计算
*/
+(float)folderSizeAtPath:(NSString *)path;

/**
* 单个文件大小的计算
*/
+(long long)fileSizeAtPath:(NSString *)path;

/**
* 清空缓存
*/
+(void)clearCache:(NSString *)path;

@end

NS_ASSUME_NONNULL_END
