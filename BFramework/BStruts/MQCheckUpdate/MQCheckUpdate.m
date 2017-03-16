//
//  MQCheckUpdate.m
//  YDHYK
//
//  Created by screson on 2017/2/20.
//  Copyright © 2017年 screson. All rights reserved.
//

#import "MQCheckUpdate.h"
#import "MQAPIURL.h"


@implementation MQCheckUpdate

+ (void)checkUpdate:(void (^)(BOOL, NSString *, BOOL))completion{
    NSString * bId      = [MQCommonUtils getBundleId];
    NSString * version  = [MQCommonUtils getBundleVersion];
    NSInteger nativeV = [[version stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
    if ([bId isEqualToString:APPSTORE_BUNDLE_ID]) {
        [self jsonObjectWithURL:APPSTORE_CHECKUPDATE callBack:^(id obj) {
            id app = [obj[@"results"] firstObject];
            if (app) {
                NSString * onlineVersion = app[@"version"];
                if ([onlineVersion isKindOfClass:[NSString class]]) {
                    NSInteger onlineV = [[onlineVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
                    if (onlineV > nativeV) {
                        if (completion) {
                            completion(true,app[@"trackViewUrl"],true);
                        }
                    }
                }
            }
        }];
    }else{
        [self jsonObjectWithURL:ENTERPRISE_CHECKUPDATE callBack:^(id obj) {
            NSString * onlineVersion = obj[@"versionName"];
            if ([onlineVersion isKindOfClass:[NSString class]]) {
                NSInteger onlineV = [[onlineVersion stringByReplacingOccurrencesOfString:@"." withString:@""] integerValue];
                if (onlineV > nativeV) {
                    if (completion) {
                        completion(true,obj[@"apkUrl"],false);
                    }
                }
            }
        }];
    }
}

+ (void)jsonObjectWithURL:(NSString *)url callBack:(void(^)(id obj))callBack{
    NSURLSession * session  = [NSURLSession sharedSession];
    NSURLSessionTask * task = [session dataTaskWithURL:[NSURL URLWithString:url] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (!error) {
            if (data) {
                id obj = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([obj isKindOfClass:[NSDictionary class]]) {
                        if (callBack) {
                            callBack(obj);
                        }
                    }
                });
            }
        }
    }];
    [task resume];
}

@end
