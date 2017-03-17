//
//  MQNetworkEngine.m
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "MQNetworkEngine.h"
#import "MQAPIURL.h"
#import "MQNotificationCenter.h"
#import "MQAPISign.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "MQDefine.h"

#define MQ_SHOW_LOG 0

NSString * MQAPI_Address(NSString * module){
    NSMutableString * strAPIURL = [NSMutableString stringWithFormat:@"%@:%@",MQROOT_URL,MQPORT];
    if (module && [module respondsToSelector:@selector(length)] && module.length) {
        if ([module hasPrefix:@"/"]) {
            [strAPIURL appendString:module];
        }else{
            [strAPIURL appendString:[NSString stringWithFormat:@"/%@",module]];
        }
    }
    return strAPIURL;
}

NSString * MQIMG_Address(NSString * path){
    NSMutableString * strAPIURL = [NSMutableString stringWithFormat:@"%@:%@",MQIMAGE_URL,MQIMAGE_PORT];
    if (path && [path respondsToSelector:@selector(length)] && path.length) {
        if ([path hasPrefix:@"/"]) {
            [strAPIURL appendString:path];
        }else{
            [strAPIURL appendString:[NSString stringWithFormat:@"/%@",path]];
        }
        
    }
    return strAPIURL;
}

@implementation MQNetworkEngine

+ (void)commonProcess:(id)content mqCompletion:(MQRequestCompletion)mqCompletion{
    if (MQ_SHOW_LOG) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:content options:NSJSONWritingPrettyPrinted error:nil];
        NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
//        NSLog(@"%@",str);
        NSLog(@"接口返回数据:\n%@",str);
        NSLog(@"------------结束------------");
    }
    if ([content isKindOfClass:[NSDictionary class]]) {
        NSInteger status = [content[@"status"] integerValue];
        
        if (status == MQAPI_LOGIN_INVALID) {
            [MQNotificationCenter postNotificationName:MQNOTICE_LOGIN_OFFLINE object:nil];
            if (mqCompletion) {
                mqCompletion(content,MQAPI_LOGIN_INVALID,true,content[@"msg"]);
            }
        }else if (mqCompletion) {
            if (status == MQAPI_SUCCESS) {
                mqCompletion(content,status,true,nil);
            }else{
                mqCompletion(content,status,true,content[@"msg"]);
            }
        }
    }else{
        if (mqCompletion) {
            mqCompletion(content,MQAPI_FORMAT_ERROR,false,MQFORMAT_ERROR_MSG);
        }
    }
}

+ (void)httpError:(NSError *)error mqCompletion:(MQRequestCompletion)mqCompletion{
    if (MQ_SHOW_LOG) {
        NSLog(@"接口错误返回数据:\n%@",error);
        NSLog(@"------------结束------------");
    }
    if (mqCompletion) {
        if (error.code == MQAPI_HTTP_TIME_OUT) {
            mqCompletion(error,MQAPI_HTTP_TIME_OUT,false,MQAPI_HTTP_TIMEOUT_MSG);
        }else{
            mqCompletion(error,MQAPI_HTTP_ERROR,false,MQAPI_HTTP_ERROR_MSG);
        }
    }
}

+ (NSURLSessionDataTask *)asyncRequestWithURL:(NSString *)url
                     params:(NSDictionary *)params
                      token:(NSString *)token
                     method:(MQRequestMethod)method mqCompletion:(MQRequestCompletion)mqCompletion{
    
    NSMutableDictionary * dicP = [NSMutableDictionary dictionaryWithDictionary:params];
    
    if ([token isKindOfClass:[NSString class]]) {
        [dicP setObject:[MQAPISign signWithDictionary:dicP withToken:token] forKey:@"sign"];//添加签名
        [dicP setObject:token forKey:@"token"];
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    manager.requestSerializer.timeoutInterval = MQAPI_TIMEOUT_INTREVAL;
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/plain"];
    NSURLSessionDataTask * task = nil;
    
    if (MQ_SHOW_LOG) {
        NSLog(@"------------开始------------");
        NSLog(@"请求地址:\n%@",url);
        NSLog(@"请求参数:\n%@",dicP);
    }
    
    switch (method) {
        case GET:
        {
            task = [manager GET:url parameters:dicP progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self commonProcess:responseObject mqCompletion:mqCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self httpError:error mqCompletion:mqCompletion];
            }];
        }
            break;
        case POST:
        {
            task = [manager POST:url parameters:dicP progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self commonProcess:responseObject mqCompletion:mqCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self httpError:error mqCompletion:mqCompletion];
            }];
        }
            break;
        case DELETE:
        {
            task = [manager DELETE:url parameters:dicP success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                [self commonProcess:responseObject mqCompletion:mqCompletion];
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                [self httpError:error mqCompletion:mqCompletion];
            }];
        }
            break;
        default:
            break;
    }
    return task;
}

+ (NSURLSessionDataTask *)uploadImageToResourceURL:(NSString *)resourceURL
                          images:(NSArray *)images
                  compressQulity:(float)qulity
                        filePath:(MQFilePath)filePath
                           token:(NSString *)token
                          params:(NSDictionary *)params
                    mqCompletion:(MQRequestCompletion)mqCompletion{
    NSMutableDictionary * dicP = [NSMutableDictionary dictionaryWithDictionary:params];
    switch (filePath) {
        case MQPathThumb:
        {
            [dicP setObject:MQAPI_Thumb_Path   forKey:@"directory"];
        }
            break;
        case MQPathChuFang:
        {
            [dicP setObject:MQAPI_ChuFang_Path forKey:@"directory"];
        }
            break;
        case MQPathHYD:
        {
            [dicP setObject:MQAPI_HYD_Path     forKey:@"directory"];
        }
            break;
        default:
            break;
    }
    
    if ([token isKindOfClass:[NSString class]]) {
        [dicP setObject:[MQAPISign signWithDictionary:dicP withToken:token] forKey:@"sign"];//添加签名
        [dicP setObject:token forKey:@"token"];
    }
    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    
    //接收类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json",
                                                         @"text/html",
                                                         @"image/jpeg",
                                                         @"image/png",
                                                         @"application/octet-stream",
                                                         @"text/json",
                                                         nil];
    
    if (MQ_SHOW_LOG) {
        NSLog(@"------------开始------------");
        NSLog(@"请求地址:%@",resourceURL);
//        NSLog(@"请求参数:\n%@",dicP);
    }
    NSURLSessionDataTask * task = [manager POST:resourceURL parameters:dicP constructingBodyWithBlock:^(id<AFMultipartFormData> _Nonnull formData) {
        
        for (id img in images) {
    
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            formatter.dateFormat =@"yyyyMMddHHmmss";
            NSString * str = [formatter stringFromDate:[NSDate date]];
            NSString * fileName = [NSString stringWithFormat:@"%@.jpg", str];
            
            //上传的参数(上传图片，以文件流的格式)
            [formData appendPartWithFileData:UIImageJPEGRepresentation(img, qulity)
                                    name:@"file"
                                fileName:fileName
                                mimeType:@"image/jpeg"];
        }
        
    } progress:^(NSProgress *_Nonnull uploadProgress) {
        //打印下上传进度
    } success:^(NSURLSessionDataTask *_Nonnull task, id _Nullable responseObject) {
        //上传成功
        [self commonProcess:responseObject mqCompletion:mqCompletion];
    } failure:^(NSURLSessionDataTask *_Nullable task, NSError * _Nonnull error) {
        //上传失败
        [self httpError:error mqCompletion:mqCompletion];
    }];
    return task;
}


@end
