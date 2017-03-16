//
//  MQDateUtils.m
//  YDHYK
//
//  Created by screson on 2016/12/16.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQDateUtils.h"

@implementation MQDateUtils

+(NSString *)getCurrentDate_TimeWithSecond:(BOOL)bNeed isChinese:(BOOL)isCHN{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [format setTimeZone:timeZone];
    if (isCHN) {
        if (bNeed) {
            [format setDateFormat:[NSString stringWithFormat:@"YYYY年MM月dd日 HH:mm:ss"]];
        }else{
            [format setDateFormat:[NSString stringWithFormat:@"YYYY年MM月dd日 HH:mm"]];
        }
    }else{
        if (bNeed) {
            [format setDateFormat:[NSString stringWithFormat:@"YYYY-MM-dd HH:mm:ss"]];
        }else{
            [format setDateFormat:[NSString stringWithFormat:@"YYYY-MM-dd HH:mm"]];
        }
    }
    return [format stringFromDate:[NSDate date]];
}

+(NSString *)getCurrentDateisChinese:(BOOL)isCHN{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [format setTimeZone:timeZone];
    if (isCHN) {
        [format setDateFormat:[NSString stringWithFormat:@"YYYY年MM月dd日"]];
    }else{
        [format setDateFormat:[NSString stringWithFormat:@"YYYY-MM-dd"]];
    }
    return [format stringFromDate:[NSDate date]];
}

+(NSString *)getCurrentTimeNeedSecond:(BOOL)bNeed{
    NSDateFormatter * format = [[NSDateFormatter alloc] init];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [format setTimeZone:timeZone];
    if (bNeed) {
        [format setDateFormat:[NSString stringWithFormat:@"HH:mm:ss"]];
    }else{
        [format setDateFormat:[NSString stringWithFormat:@"HH:mm"]];
    }
    return [format stringFromDate:[NSDate date]];
}


+(NSString *)dateFromMilliSecond:(NSNumber *)mSecond isCHN:(BOOL)isCHN needTime:(BOOL)bTime splitChar:(NSString *)splitChar{
    if ([mSecond longLongValue]!=0) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        [formatter setTimeZone:timeZone];
        if (isCHN) {
            if (bTime) {
                [formatter setDateFormat:@"YYYY年MM月dd日 HH:mm"];
            }else{
                [formatter setDateFormat:@"YYYY年MM月dd日"];
            }
        }else{
            if (bTime) {
                [formatter setDateFormat:[NSString stringWithFormat:@"YYYY%@MM%@dd HH:mm",splitChar,splitChar]];
            }else{
                [formatter setDateFormat:[NSString stringWithFormat:@"YYYY%@MM%@dd",splitChar,splitChar]];
            }
        }
        //NSLog(@"--/%lld/",[mSecond longLongValue]);
        NSString *date =  [formatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:[mSecond longLongValue]/1000]];
        //不能除以1000.0f 造成比较大的误差
        return date;
    }
    return @"00:00:00";
}

+(NSString*)timeFromMillSecond:(NSNumber*)mSecond needSecond:(BOOL)bSecond{
    if ([mSecond longLongValue]!=0) {
        NSDateFormatter * formatter = [[NSDateFormatter alloc ] init];
        NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
        [formatter setTimeZone:timeZone];
        if (bSecond) {
            [formatter setDateFormat:[NSString stringWithFormat:@"HH:mm:ss"]];
        }else{
            [formatter setDateFormat:[NSString stringWithFormat:@"HH:mm"]];
        }
        NSString *date =  [formatter stringFromDate:[[NSDate alloc] initWithTimeIntervalSince1970:[mSecond longLongValue]/1000]];
        //不能除以1000.0f 造成比较大的误差
        return date;
    }
    return @"00:00:00";
}

+(NSString*)millSecondFromDate:(NSString *)timeStr hasSecond:(BOOL)bSecond splitChar:(NSString *)splitChar{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    if (bSecond) {
        [formatter setDateFormat:[NSString stringWithFormat:@"YYYY%@MM%@dd HH:mm:ss",splitChar,splitChar]];
    }else{
        [formatter setDateFormat:[NSString stringWithFormat:@"YYYY%@MM%@dd HH:mm",splitChar,splitChar]];
    }
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    NSDate* date = [formatter dateFromString:timeStr]; //------------将字符串按formatter转成nsdate
    //    时间转时间戳的方法:
    //NSLog(@"%f",[date timeIntervalSince1970]);
    NSString *timeSp = [NSString stringWithFormat:@"%@", [NSNumber numberWithLongLong:[date timeIntervalSince1970] * 1000]];
    return timeSp;
}

//
+(NSString *)UTCDateTOLocalDate:(NSString *)utcDate toCHN:(BOOL)bCHN needSecond:(BOOL)bNeedSecond{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //输入格式
    [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
    NSTimeZone *localTimeZone = [NSTimeZone localTimeZone];
    [dateFormatter setTimeZone:localTimeZone];
    NSDate *dateFormatted = [dateFormatter dateFromString:utcDate];
    //输出格式
    if (bCHN) {
        if (bNeedSecond) {
            [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
        }else{
            [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        }
    }else{
        if (bNeedSecond) {
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }else{
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }
    }
    
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    
    return dateString;
}

+(NSString *)LocalDateToUTCDate:(NSString *)localDate isCHN:(BOOL)isCHN hasSecond:(BOOL)bSecond {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    //输入格式
    if (isCHN) {
        if (bSecond) {
            [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm:ss"];
        }else{
            [dateFormatter setDateFormat:@"yyyy年MM月dd日 HH:mm"];
        }
    }else{
        if (bSecond) {
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        }else{
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
        }
    }
    
    NSDate *dateFormatted = [dateFormatter dateFromString:localDate];
    NSTimeZone *timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    [dateFormatter setTimeZone:timeZone];
    
    //输出格式
    if (isCHN) {
        if (bSecond) {
            [dateFormatter setDateFormat:@"yyyy年MM月dd'T'HH:mm:ssZ"];
        }else{
            [dateFormatter setDateFormat:@"yyyy年MM月dd'T'HH:mmZ"];
        }
    }else{
        if (bSecond) {
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ssZ"];
        }else{
            [dateFormatter setDateFormat:@"yyyy-MM-dd'T'HH:mmZ"];
        }
    }
    NSString *dateString = [dateFormatter stringFromDate:dateFormatted];
    
    return dateString;
}

+ (long long)currentMillSeconds{
    return [[NSDate date] timeIntervalSince1970] * 1000;
}

+ (NSDate *)mq_Date{
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return localeDate;
}


+(NSString *)timeCountToTime:(int)tCount{
    NSDateFormatter * dateF = [[NSDateFormatter alloc] init];
    [dateF setDateFormat:[NSString stringWithFormat:@"HH:mm:ss"]];
    NSString * currDateCount = [dateF stringFromDate:[NSDate dateWithTimeInterval:tCount sinceDate:[dateF dateFromString:@"00:00:00"]]];
    return currDateCount;
}

+(NSString *)getDateAfterTodayMillSeconds:(NSNumber *)Mseconds{
    NSDate* date = [NSDate date];
    long long temptime = [date timeIntervalSince1970] * 1000;
    long long sTime = temptime + [Mseconds longLongValue];
    NSString * tDate =[MQDateUtils dateFromMilliSecond:[NSNumber numberWithLongLong:sTime] isCHN:false needTime:false splitChar:@"-"];
    return tDate;
}

+(NSComparisonResult)compareWithLastDate:(NSString*)lastDateStr withNextDate:(NSString*)nextDateStr{
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *nextDate = [[NSDate alloc] init];
    NSDate *lastDate = [[NSDate alloc] init];
    
    nextDate = [dateformater dateFromString:nextDateStr];
    lastDate = [dateformater dateFromString:lastDateStr];
    NSComparisonResult result = [lastDate compare:nextDate];
    return result;
}

@end
