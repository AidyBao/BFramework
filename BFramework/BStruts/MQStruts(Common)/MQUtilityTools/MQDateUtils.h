//
//  MQDateUtils.h
//  YDHYK
//
//  Created by screson on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQDateUtils : NSObject

/**
 *  获取当前日期和时间
 *
 *  @param bNeed 是否需要返回秒钟
 *  @param isCHN 日期是否中文显示
 *
 *  @return return value description
 */
+(NSString *)getCurrentDate_TimeWithSecond:(BOOL)bNeed
                                 isChinese:(BOOL)isCHN;
/**
 *  获取当前日期
 *
 *  @param isCHN 是否中文显示  NO: "-"分隔
 *
 *  @return return value description
 */
+(NSString *)getCurrentDateisChinese:(BOOL)isCHN;

/**
 *  获取当前时间
 *
 *  @param bNeed 是否需要返回秒钟
 *
 *  @return return value description
 */
+(NSString *)getCurrentTimeNeedSecond:(BOOL)bNeed;

/**
 *  时间戳转日期+时间
 *
 *  @param mSecond   时间戳 longlongValue
 *  @param isCHN     日期是否中文显示
 *  @param bTime     是否需要返回时间
 *  @param splitChar f非中文显示 "-"分隔 传nil
 *
 *  @return return value description
 */
+(NSString *)dateFromMilliSecond:(NSNumber*)mSecond
                           isCHN:(BOOL)isCHN
                        needTime:(BOOL)bTime
                       splitChar:(NSString *)splitChar;

/**
 *  时间戳提取时间
 *
 *  @param mSecond 时间戳 longlongValue
 *
 *  @return return value description
 */
+(NSString *)timeFromMillSecond:(NSNumber*)mSecond needSecond:(BOOL)bSecond;

/**
 *  日期转时间戳
 *
 *  @param timeStr   日期
 *  @param bSecond   是否包含秒钟值
 *  @param splitChar 日期分隔符
 *
 *  @return return value description
 */
+(NSString *)millSecondFromDate:(NSString *)timeStr
                      hasSecond:(BOOL)bSecond
                      splitChar:(NSString *)splitChar;

/**
 *  UTC 标准时间 转本地时间
 *
 *  @param utcDate     utcDate description
 *  @param bCHN        bCHN description
 *  @param bNeedSecond bNeedSecond description
 *
 *  @return return value description
 */
+(NSString *)UTCDateTOLocalDate:(NSString *)utcDate
                          toCHN:(BOOL)bCHN
                     needSecond:(BOOL)bNeedSecond;

/**
 *  本地时间转换为UTC 标准时间
 *
 *  @param localTime localTime description
 *
 *  @return return value description
 */
+(NSString *)LocalDateToUTCDate:(NSString *)localTime
                          isCHN:(BOOL)isCHN
                      hasSecond:(BOOL)bSecond;

+ (long long)currentMillSeconds;
/**
 *  秒表数转时间
 *
 *  @param tCount tCount description
 *
 *  @return return value description
 */
+(NSString *)timeCountToTime:(int)tCount;

+(NSString *)getDateAfterTodayMillSeconds:(NSNumber *)Mseconds;

/**
 *  时间大小比较
 *
 *  @param nextDateStr 上一次时间
 *  @param lastDateStr 下一次时间
 *  @return NSComparisonResult
 */
+(NSComparisonResult)compareWithLastDate:(NSString*)lastDateStr withNextDate:(NSString*)nextDateStr;

@end
