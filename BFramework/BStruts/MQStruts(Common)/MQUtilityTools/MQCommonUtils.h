//
//  MQCommonUtils.h
//  YDHYK
//
//  Created by screson on 2016/12/17.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQCommonUtils : NSObject

+ (void)openCallWithTelNum:(NSString *)telNum;
+ (void)openApplicationURL:(NSString *)url;

/**获取大版本号*/
+ (NSString *)getBundleVersion;
/**获取小版本号*/
+ (NSString *)getBundleBuild;

/**BundleID*/
+ (NSString *)getBundleId;

+ (void)showNetworkActivityIndicatorVisible:(BOOL)visible;

@end
