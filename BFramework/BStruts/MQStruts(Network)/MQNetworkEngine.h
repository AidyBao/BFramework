//
//  ZXNetworkEngine.h
//  ZXStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQAPISign.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <AFNetworking/UIButton+AFNetworking.h>

/**构造完整接口地址*/
extern NSString * MQAPI_Address(NSString * module);
/**构造完整资源地址*/
extern NSString * MQIMG_Address(NSString * imgPath);

typedef enum : NSUInteger {
    POST,
    GET,
    DELETE,
} MQRequestMethod;

typedef enum : NSUInteger {
    MQPathThumb,  //头像
    MQPathChuFang,//处方
    MQPathHYD,    //化验单
    MQPathCustom  //自定义
} MQFilePath;

/**content：接口返回的原始数据
 * code:    从接口解析的状态码
 * success: true:接口访问成功（不代表code = 0） false 接口访问失败
 * errorMsg: 接口错误信息，取值于接口msg字段
 */
typedef void(^MQRequestCompletion)(id content,NSInteger status,BOOL success,NSString * errorMsg);
typedef void(^MQEmptyCallBack)(void);

@interface MQNetworkEngine : NSObject

/**统一接口数据处理*/
+ (void)commonProcess:(id)content mqCompletion:(MQRequestCompletion)mqCompletion;
/**HTTP 请求失败*/
+ (void)httpError:(NSError *)error mqCompletion:(MQRequestCompletion)mqCompletion;


//为了保证签名正确，所有值类型必须是值类型 mq_description
/**
 *  异步接口请求
 *
 *  @param url          接口地址
 *  @param params       接口参数
 *  @param token        有Token 才添加签名
 *  @param method       请求方式 GET POST DELETE
 *  @param mqCompletion 接口请求完成回调
 */

+ (NSURLSessionDataTask *)asyncRequestWithURL:(NSString *)url
                                       params:(NSDictionary *)params
                                        token:(NSString *)token
                                       method:(MQRequestMethod)method
                                 mqCompletion:(MQRequestCompletion)mqCompletion;


//为了保证签名正确，所有值类型必须是值类型 mq_description
/**
 *  图片文件上传
 *
 *  @param resourceURL 资源接口地址
 *  @param images      图片数组
 *  @param token       签名用
 *  @param qulity      压缩图片质量 0~1 0 最大压缩 1 不压缩
 *  @param params      接口请求参数
 *  @param mqCompletion    请求完成回调
 */

+(NSURLSessionDataTask *)uploadImageToResourceURL:(NSString *)resourceURL
                                           images:(NSArray *)images
                                   compressQulity:(float)qulity
                                         filePath:(MQFilePath)filePath
                                            token:(NSString *)token
                                           params:(NSDictionary *)params
                                     mqCompletion:(MQRequestCompletion)mqCompletion;

@end
