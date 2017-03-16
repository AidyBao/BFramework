//
//  LoginViewModel.m
//  BFramework
//
//  Created by 120v on 2017/3/6.
//  Copyright © 2017年 120v. All rights reserved.
//

#import "LoginViewModel.h"
#import "LoginRootViewController.h"
#import "LaunchRootViewController.h"

@implementation LoginViewModel

+ (void)loginInvalidWith:(BOOL)isProcess completion:(void(^)(BOOL reLogin))completion{
    if (!isProcess) {
        return;
    }
    __block BOOL reLogin = false;
    id keyVC = [MQRootViewControllers keyController];
    if ([keyVC isKindOfClass:[UINavigationController class]]) {
        keyVC = [[keyVC viewControllers] firstObject];
    }
    if (!([keyVC isKindOfClass:[LoginRootViewController class]] ||
          [keyVC isKindOfClass:[UINavigationController class]] ||
          [keyVC isKindOfClass:[LaunchRootViewController class]])) {
        [MQAlertUtils showAAlertWithTitle:nil message:@"您的登录已失效,请重新登录!" buttonText:@"重新登录" buttonAction:^{
            reLogin = true;

            //1.
            [[APPManager shareManager] cleanAll];
            
            //2.保存登录状态
            [[APPManager shareManager] loginModel].isLoginSataus = NO;
            [[APPManager shareManager] saveLoginSataus];
            
            //3.清空tabBar
            [MQRootViewControllers reload];
            
            //4.
            LoginRootViewController *loginVC = [[LoginRootViewController alloc]initWithNibName:@"LoginRootViewController" bundle:nil];
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            UINavigationController *navVC = [[UINavigationController alloc]initWithRootViewController:loginVC];
            [[MQRootViewControllers keyController] presentViewController:navVC animated:YES completion:nil ];
        }];
    }else{
        reLogin = true;
    }
    
    if (completion) {
        completion(reLogin);
    }
    
}

@end
