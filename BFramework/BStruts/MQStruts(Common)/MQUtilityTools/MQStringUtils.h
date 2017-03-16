//
//  MQStringUtils.h
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MQStringUtils : NSObject

/**
 *  判断某个字符串是否匹配某个正则
 *
 *  @param baseString    待检测字符串
 *  @param regularString 正则
 *
 *  @return return value description
 */
+ (BOOL)isString:(NSString *)baseString matchingRegularString:(NSString *)regularString;

/**
 *  6-20 位字母+数字
 *
 *  @param password password description
 *
 *  @return return value description
 */

+ (BOOL)isPasswordValid:(NSString*)password;

/**
 *  只判断数字位数，第一位为1
 *
 *  @param mobile mobile description
 *
 *  @return return value description
 */

+ (BOOL)isMobileValid:(NSString*)mobile;

/**
 *  Description
 *
 *  @param email email description
 *
 *  @return return value description
 */

+ (BOOL)isEmailValid:(NSString *)email;

/**
 *  字符串是否为空 空值 空串 空格 非NSString类型
 *
 *  @param str str description
 *
 *  @return return value description
 */
+ (BOOL)isTextEmpty:(NSString*)str;

/**
 *  生成UUID
 *
 *  @return return value description
 */

+(NSString *)generateUUIDString;

/**
 *  计算字符串尺寸
 *
 *  @param string    string description
 *  @param font      font description
 *  @param limitSize limitSize description
 *
 *  @return return value description
 */

+(CGSize)caculateStringSizeWithString:(NSString *)string
                                 font:(UIFont *)font
                            limitSize:(CGSize)limitSize;

/**
 *  修改为价格格式 eg:¥12,001
 *
 *  @param num num description
 *
 *  @return return value description
 */
+ (NSString *)priceFormate:(NSString *)num;

/**
 *  是否是中文
 *
 *  @param text text description
 *
 *  @return return value description
 */
+ (BOOL)isChinese:(NSString *)text;

/**
 *  md5 加密
 *
 *  @param str str description
 *
 *  @return return value description
 */
+(NSString*)md5_32bit:(NSString*)str;
+(NSString*)md5_16bit:(NSString*)str;

@end
