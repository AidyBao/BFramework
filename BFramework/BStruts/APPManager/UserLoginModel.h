//
//  UserLoginModel.h
//  YDGJ
//
//  Created by 120v on 2017/2/3.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserLoginModel : NSObject

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

@end
