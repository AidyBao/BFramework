//
//  APPManager.m
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "APPManager.h"
@interface APPManager()

@property (nonatomic,strong) UserLoginModel *loginModel;

@end


@implementation APPManager
static id appManagerInstance;

#pragma mark - 获取实例
+(id)shareManager{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        appManagerInstance = [[self alloc]init];
    });
    return appManagerInstance;
}

-(instancetype)init{
    if (self = [super init]) {
    }
    return self;
}

#pragma mark - 保存
-(void)saveUserLoginWithDict:(NSDictionary *)dict{
    if (dict) {
        self.loginModel = [UserLoginModel mj_objectWithKeyValues:dict];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setObject:[NSString stringWithFormat:@"%@",self.loginModel.appVersion] forKey:@"appVersion"];
        [userDefaults setObject:self.loginModel.deviceToken forKey:@"deviceToken"];
        [userDefaults setObject:self.loginModel.failedTimes forKey:@"failedTimes"];
        [userDefaults setObject:self.loginModel.headPortrait forKey:@"headPortrait"];
        [userDefaults setObject:self.loginModel.headPortraitStr forKey:@"headPortraitStr"];
        [userDefaults setObject:self.loginModel.uid forKey:@"uid"];
        [userDefaults setObject:self.loginModel.loginTime forKey:@"loginTime"];
        [userDefaults setObject:self.loginModel.mobileModel forKey:@"mobileModel"];
        [userDefaults setObject:self.loginModel.mobileSystemType forKey:@"mobileSystemType"];
        [userDefaults setObject:self.loginModel.mobileSystemVersion forKey:@"mobileSystemVersion"];
        [userDefaults setObject:self.loginModel.name forKey:@"name"];
        [userDefaults setObject:self.loginModel.operationDate forKey:@"operationDate"];
        [userDefaults setObject:self.loginModel.operatorId forKey:@"operatorId"];
        [userDefaults setObject:self.loginModel.operatorName forKey:@"operatorName"];
        [userDefaults setObject:self.loginModel.passWord forKey:@"passWord"];
        [userDefaults setObject:self.loginModel.position forKey:@"position"];
        [userDefaults setObject:self.loginModel.qrCode forKey:@"qrCode"];
        [userDefaults setObject:self.loginModel.remark forKey:@"remark"];
        [userDefaults setObject:self.loginModel.status forKey:@"status"];
        [userDefaults setObject:self.loginModel.tel forKey:@"tel"];
        [userDefaults setObject:self.loginModel.token forKey:@"token"];
        [userDefaults setObject:self.loginModel.userName forKey:@"userName"];
        [userDefaults setObject:self.loginModel.uuid forKey:@"uuid"];
        [userDefaults synchronize];
    }
}


#pragma mark 保存登录状态
-(void)saveLoginSataus{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setBool:self.loginModel.isLoginSataus forKey:@"isLoginSataus"];
    [userDefault synchronize];
}


#pragma mark 修改用户名字
- (void)updateName{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginModel.name forKey:@"name"];
    [userDefault synchronize];
}

#pragma mark 修改用户名字
- (void)updateTelphoneNumber{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginModel.tel forKey:@"tel"];
    [userDefault synchronize];
}

#pragma mark 修改密码
- (void)updatePassword{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginModel.passWord forKey:@"passWord"];
    [userDefault synchronize];
}

#pragma mark 修改头像
- (void)updateHeadPortraitStr{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:self.loginModel.headPortraitStr forKey:@"headPortraitStr"];
    [userDefault synchronize];
}

#pragma mark 保存明文密码
+ (void)saveLocationPassword:(NSString *)passWord{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSString stringWithFormat:@"%@",passWord] forKey:@"locationPassword"];
}

#pragma mark 消息推送Token
+ (void)saveNoticeDeviceToken:(NSString *)deviceToken{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    [userDefault setObject:[NSString stringWithFormat:@"%@",deviceToken] forKey:@"noticeDeviceToken"];
}


#pragma mark - 获取
#pragma mark 获取登录状态
+ (BOOL)getIsLoginSataus{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    BOOL loginSataus = [[userDefaults objectForKey:@"isLoginSataus"] boolValue];
    return loginSataus;
}

#pragma mark 获取明文密码
+ (NSString *)getLocationPassword{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"locationPassword"];
}

#pragma mark 获取消息推送Token
+ (NSString *)getNoticeDeviceToken{
        return [[NSUserDefaults standardUserDefaults]objectForKey:@"noticeDeviceToken"];
}

#pragma mark 获取deviceToken
+ (NSString *)getDeviceToken{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"deviceToken"];
}

#pragma mark 获取failedTimes
+ (NSString *)getFailedTimes{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"failedTimes"];
}

#pragma mark 获取headPortrait
+ (NSString *)getHeadPortrait{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"headPortrait"];
}

#pragma mark 获取headPortraitStr
+ (NSString *)getheadPortraitStr{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"headPortraitStr"];
}

#pragma mark 获取uid
+ (NSString *)getUID{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"uid"];
}

#pragma mark 获取loginTime
+ (NSString *)getLoginTime{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"loginTime"];
}

#pragma mark 获取mobileModel
+ (NSString *)getMobileModel{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"mobileModel"];
}

#pragma mark 获取mobileSystemType
+ (NSString *)getMobileSystemType{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"mobileSystemType"];
}

#pragma mark 获取mobileSystemVersion
+ (NSString *)getMobileSystemVersion{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"mobileSystemVersion"];
}

#pragma mark 获取name
+ (NSString *)getName{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"name"];
}

#pragma mark 获取operationDate
+ (NSString *)getOperationDate{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"operationDate"];
}

#pragma mark 获取operatorId
+ (NSString *)getOperatorId{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"operatorId"];
}

#pragma mark 获取operatorName
+ (NSString *)getOperatorName{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"operatorName"];
}

#pragma mark 获取passWord
+ (NSString *)getPassWord{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"passWord"];
}
#pragma mark 获取position
+ (NSString *)getPosition{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"position"];
}
#pragma mark 获取qrCode
+ (NSString *)getQrCode{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"qrCode"];
}
#pragma mark 获取remark
+ (NSString *)getRemark{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"remark"];
}
#pragma mark 获取status
+ (NSString *)getStatus{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"status"];
}
#pragma mark 获取tel
+ (NSString *)getTel{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"tel"];
}
#pragma mark 获取token
+ (NSString *)getToken{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
}
#pragma mark 获取userName
+ (NSString *)getUserName{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"userName"];
}
#pragma mark 获取uuid
+ (NSString *)getUUID{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"uuid"];
}

#pragma mark - 清空用户信息
-(void)cleanAll{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:@"appVersion"];
    [userDefaults removeObjectForKey:@"deviceToken"];
    [userDefaults removeObjectForKey:@"failedTimes"];
    [userDefaults removeObjectForKey:@"headPortrait"];
    [userDefaults removeObjectForKey:@"uid"];
    [userDefaults removeObjectForKey:@"loginTime"];
    [userDefaults removeObjectForKey:@"mobileModel"];
    [userDefaults removeObjectForKey:@"mobileSystemType"];
    [userDefaults removeObjectForKey:@"mobileSystemVersion"];
    [userDefaults removeObjectForKey:@"name"];
    [userDefaults removeObjectForKey:@"operationDate"];
    [userDefaults removeObjectForKey:@"operatorId"];
    [userDefaults removeObjectForKey:@"operatorName"];
    [userDefaults removeObjectForKey:@"passWord"];
    [userDefaults removeObjectForKey:@"position"];
    [userDefaults removeObjectForKey:@"qrCode"];
    [userDefaults removeObjectForKey:@"remark"];
    [userDefaults removeObjectForKey:@"status"];
    [userDefaults removeObjectForKey:@"tel"];
    [userDefaults removeObjectForKey:@"token"];
    [userDefaults removeObjectForKey:@"userName"];
    [userDefaults removeObjectForKey:@"uuid"];
    [userDefaults removeObjectForKey:@"isLoginSataus"];
    [userDefaults removeObjectForKey:@"headPortraitStr"];
    [userDefaults removeObjectForKey:@"locationPassword"];
    [userDefaults removeObjectForKey:@"noticeDeviceToken"];
    
    [userDefaults synchronize];
    
    _loginModel = nil;
}


#pragma mark - lazy
-(UserLoginModel *)loginModel{
    if (!_loginModel) {
        _loginModel = [[UserLoginModel alloc]init];
    }
    return _loginModel;
}

@end
