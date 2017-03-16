//
//  UserLoginModel.m
//  YDGJ
//
//  Created by 120v on 2017/2/3.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "UserLoginModel.h"

@implementation UserLoginModel

-(instancetype)init{
    if ([super init]) {
        //将key值id更换为uid
        [UserLoginModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}

@end
