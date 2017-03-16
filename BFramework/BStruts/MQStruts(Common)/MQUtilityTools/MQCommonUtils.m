//
//  MQCommonUtils.m
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQCommonUtils.h"
#import <UIKit/UIKit.h>

@implementation MQCommonUtils

+ (void)openApplicationURL:(NSString *)url{
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_10_0
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url] options:@{} completionHandler:nil];
#else
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
#endif
}

+ (void)openCallWithTelNum:(NSString *)telNum{
    [self openApplicationURL:[NSString stringWithFormat:@"tel://%@",telNum]];
}

+ (NSString *)getBundleVersion{
    return [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];//
}

+ (NSString *)getBundleBuild{
    return [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"]];//
}

+ (NSString *)getBundleId{
    return [NSString stringWithFormat:@"%@",[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"]];
}


+ (void)showNetworkActivityIndicatorVisible:(BOOL)visible{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:visible];
}

@end
