//
//  MQCheckUpdate.h
//  YDHYK
//
//  Created by screson on 2017/2/20.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface MQCheckUpdate : NSObject

+ (void)checkUpdate:(void(^)(BOOL needUpdate,NSString * updateURL,BOOL appStoreType))completion;

@end
