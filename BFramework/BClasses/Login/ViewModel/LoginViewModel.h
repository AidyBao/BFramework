//
//  LoginViewModel.h
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LoginViewModel : NSObject

/**
 @program 登录失败处理
 @isProcess 登录状态
 @completion 回调登录状态
 **/
+ (void)loginInvalidWith:(BOOL)isProcess completion:(void(^)(BOOL reLogin))completion;

@end
