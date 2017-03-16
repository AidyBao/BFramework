//
//  ZXStruts.h
//  ZXStructure
//
//  JuanFelix on 23/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#ifndef ZXStruts_h
#define ZXStruts_h

#import "AppDelegate.h"

#import "MQStrutsEngine.h"
#import "MQCommonEngine.h"  //基础UI配置
#import "MQRouterEngine.h"  //界面跳转控制
#import "MQNetworkEngine.h" //接口请求相关
#import "MQWebEngine.h"

#import "MQHUD.h"
#import "MQDefine.h"        //接口地址及通用常量定义
#import "MQNotificationCenter.h"
#import "Base64.h"
#import "MQCheckUpdate.h"

#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\n %s:%d   %s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String],__LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(...)
#endif

#endif /* ZXStruts_h */
