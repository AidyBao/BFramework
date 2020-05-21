//
//  BBUserModel.m
//  BFramework
//
//  Created by 120v on 2020/5/21.
//  Copyright © 2020 120v. All rights reserved.
//

#import "BBUserModel.h"

static BBUserModel *user = nil;
static NSString *keyName = @"BBUser";

@implementation BBUserModel

-(instancetype)init{
    if ([super init]) {
        //将key值id更换为uid
        [BBUserModel mj_setupReplacedKeyFromPropertyName:^NSDictionary *{
            return @{@"uid":@"id"};
        }];
    }
    return self;
}

+(id)share{
    static dispatch_once_t oneToken;
    dispatch_once(&oneToken,^{
        user = [[self alloc]init];
    });
    return user;
}

// 重置单例
+ (void)resetUserModel {
    user = nil;
}

// 清除本地的所有用户数据
+ (void)clearLocalUserModel {
    // 把登录状态置为NO
    // 重置用户单例
    [BBUserModel resetUserModel];
    // 清空用户本地化缓存的数据
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:keyName];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark - * * * * * 下面两个方法需要需要引入 YYModel 方能使用 * * * * *

// 更新本地的用户数据
+ (void)updateLocalUserModel:(BBUserModel *)user
{
    // 将用户模型转换成json数据
    NSData *data = [user mj_JSONData];
    // 将用户数据存储到本地
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:keyName];
    // 立即同步到文件
    [[NSUserDefaults standardUserDefaults] synchronize];
}

// 加载本地的用户模型
+ (BBUserModel *)loadLocalUserModel {
    NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:keyName];
    if (!data) {
        return nil;
    }
    return [BBUserModel mj_objectWithKeyValues:data];
}


#pragma mark - 单个文件大小的计算
+(long long)fileSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]){
        long long size=[fileManager attributesOfItemAtPath:path error:nil].fileSize;
        return size;
    }
    return 0;
}

#pragma mark - 文件夹大小的计算
+(float)folderSizeAtPath:(NSString *)path{
    NSFileManager *fileManager=[NSFileManager defaultManager];
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath=[cachePath stringByAppendingPathComponent:path];
    long long folderSize=0;
    if ([fileManager fileExistsAtPath:cachePath]){
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles){
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            long long size=[self fileSizeAtPath:fileAbsolutePath];
            folderSize += size;
        }
        //SDWebImage框架自身计算缓存的实现
        folderSize+=[[SDImageCache sharedImageCache] getSize];
        return folderSize/1024.0/1024.0;
    }
    return 0;
}

#pragma mark - 清理缓存
+(void)clearCache:(NSString *)path{
    NSString *cachePath=[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    cachePath=[cachePath stringByAppendingPathComponent:path];
    
    NSFileManager *fileManager=[NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:cachePath]) {
        NSArray *childerFiles=[fileManager subpathsAtPath:cachePath];
        for (NSString *fileName in childerFiles) {
            //如有需要，加入条件，过滤掉不想删除的文件
            NSString *fileAbsolutePath=[cachePath stringByAppendingPathComponent:fileName];
            [fileManager removeItemAtPath:fileAbsolutePath error:nil];
        }
    }
    [[SDImageCache sharedImageCache] clearMemory];
}

@end
