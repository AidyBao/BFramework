//
//  MQStringUtils.m
//  MQStructure
//
//  JuanFelix on 27/11/2016.
//  Copyright © 2016 screson. All rights reserved.
//

#import "MQStringUtils.h"
#import <CommonCrypto/CommonCrypto.h>
#define PASSWORD_REG @"^(?![^a-zA-Z]+$)(?!\\D+$).{6,20}$" //6-20位字母+数字
#define MOBILE_REG   @"[1]\\d{10}$"
#define EMAIL_REG    @"\\b([a-zA-Z0-9%_.+\\-]+)@([a-zA-Z0-9.\\-]+?\\.[a-zA-Z]{2,6})\\b"

@implementation MQStringUtils : NSObject 

+ (BOOL)isString:(NSString *)baseString matchingRegularString:(NSString *)regularString{
    NSPredicate *regextestPredicate= [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regularString];
    return [regextestPredicate evaluateWithObject:baseString];
}

+ (NSString *)generateUUIDString{
    CFUUIDRef uuid_ref = CFUUIDCreate(nil);
    CFStringRef uuid_string_ref= CFUUIDCreateString(nil, uuid_ref);
    CFRelease(uuid_ref);
    NSString *uuid = [NSString stringWithString:(__bridge NSString*)uuid_string_ref];
    CFRelease(uuid_string_ref);
    return uuid;
}

+ (BOOL)isPasswordValid:(NSString *)password{
    return [MQStringUtils isString:password matchingRegularString:PASSWORD_REG];
}

+ (BOOL)isEmailValid:(NSString *)email{
    return [MQStringUtils isString:email matchingRegularString:EMAIL_REG];
}

+ (BOOL)isMobileValid:(NSString *)mobile{
    return [MQStringUtils isString:mobile matchingRegularString:MOBILE_REG];
}

+ (BOOL)isTextEmpty:(NSString *)str{
    if (str == nil || (id)str == [NSNull null]) {
        return YES;
    }else{
        if (![str respondsToSelector:@selector(length)]) {
            return YES;
        }
        str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([str length]) {
            return NO;
        }
    }
    return YES;
}



+ (CGSize)caculateStringSizeWithString:(NSString *)string
                                  font:(UIFont *)font
                             limitSize:(CGSize)limitSize{
    NSDictionary *attribute = @{NSFontAttributeName: font};
    //    CGSizeMake(100, MAXFLOAT)
    CGSize textSize = [string boundingRectWithSize:limitSize options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingTruncatesLastVisibleLine attributes:attribute context:nil].size;
    return textSize;
}

+ (NSString *)priceFormate:(NSString *)num{
    long long int a = 0;
    NSMutableString * string = nil;
    NSArray * arr = [num componentsSeparatedByString:@"."];
    
    if (arr && [arr count] > 1) {//有小数
        a = [[arr firstObject] longLongValue];
        string = [NSMutableString stringWithString:[arr firstObject]];
    }else{
        a = num.longLongValue;
        string = [NSMutableString stringWithString:num];
    }
    
    int count = 0;
    while (a != 0)
    {
        count++;
        a /= 10;
    }
    NSMutableString *newstring = [NSMutableString string];
    while (count > 3) {
        count -= 3;
        NSRange rang = NSMakeRange(string.length - 3, 3);
        NSString *str = [string substringWithRange:rang];
        [newstring insertString:str atIndex:0];
        [newstring insertString:@"," atIndex:0];
        [string deleteCharactersInRange:rang];
    }
    [newstring insertString:string atIndex:0];
    
    if (arr && [arr count] > 1) {//有小数
        [newstring appendString:@"."];
        [newstring appendString:[arr lastObject]];
    }
    [newstring insertString:@"¥" atIndex:0];
    return newstring;
}


+(BOOL)isChinese:(NSString *)text{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:text];
}

+(NSString*)md5_32bit:(NSString*)str{
    const char *cStr = [str UTF8String];
    unsigned char result[32];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:
            @"%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x%x",
            result[0],result[1],result[2],result[3],
            result[4],result[5],result[6],result[7],
            result[8],result[9],result[10],result[11],
            result[12],result[13],result[14],result[15],
            result[16], result[17],result[18], result[19],
            result[20], result[21],result[22], result[23],
            result[24], result[25],result[26], result[27],
            result[28], result[29],result[30], result[31]];
}

+(NSString*)md5_16bit:(NSString*)str{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

@end
