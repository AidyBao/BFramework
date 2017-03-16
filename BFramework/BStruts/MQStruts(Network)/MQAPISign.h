//
//  MQAPISign.h
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

/**接口签名规则*/
@interface MQAPISign : NSObject

+ (NSString *)signWithDictionary:(NSDictionary *)dicParams withToken:(NSString *)token;

@end
