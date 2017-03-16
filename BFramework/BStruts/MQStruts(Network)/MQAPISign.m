//
//  MQAPISign.m
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQAPISign.h"
#import "MQAPIURL.h"
#import "MQStringUtils.h"
#import <MJExtension/MJExtension.h>
#import <OrderedDictionary/OrderedDictionary.h>

@implementation MQAPISign

+ (NSString *)signWithDictionary:(NSDictionary *)dict1 withToken:(NSString *)token{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionaryWithDictionary:dict1];
    if (dicP && dicP.count) {
        [dicP enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
            if (![obj isKindOfClass:[NSString class]]) {
                [dicP setObject:[NSString stringWithFormat:@"%@",obj] forKey:key];
            }
        }];
        
    }
    //按字母升序排序
    NSArray *keys = [dicP allKeys];
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    
    MutableOrderedDictionary *resultDict = [MutableOrderedDictionary dictionary];
    for (int i =0; i<sortedArray.count; i++) {
        NSString *dickey = sortedArray[i];
        [resultDict insertObject:[dicP objectForKey:dickey] forKey:dickey atIndex:i];
    }
    //字典转json
    NSString *jsonString = [resultDict mj_JSONString];
    jsonString = [jsonString stringByReplacingOccurrencesOfString:@"\\/" withString:@"/"];
    NSString *passWordStr = [jsonString stringByAppendingString:MQAPI_KEY];
    NSString *resultString = nil;
    if (token) {
        resultString = [passWordStr stringByAppendingString:token];
    }
    //加密
    NSString *MD5String = [MQStringUtils md5_16bit:resultString];
    return MD5String;

}

@end
