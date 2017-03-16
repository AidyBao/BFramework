//
//  NSString+Category.m
//  YDHYK
//
//  Created by 120v on 2016/12/5.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Category)

#pragma mark - 获取汉字转成拼音字符串
+(NSString *)transformToPinyin:(NSString *)aString{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    NSArray *pinyinArray = [str componentsSeparatedByString:@" "];
    NSMutableString *allString = [NSMutableString new];
    
    int count = 0;
    
    for (int  i = 0; i < pinyinArray.count; i++){
        
        for(int i = 0; i < pinyinArray.count;i++){
            if (i == count) {
                [allString appendString:@"#"];//区分第几个字母
            }
            [allString appendFormat:@"%@",pinyinArray[i]];
            
        }
        [allString appendString:@","];
        count ++;
        
    }
    
    NSMutableString *initialStr = [NSMutableString new];//拼音首字母
    
    for (NSString *s in pinyinArray){
        if (s.length > 0){
            
            [initialStr appendString:  [s substringToIndex:1]];
        }
    }
    
    [allString appendFormat:@"#%@",initialStr];
    [allString appendFormat:@",#%@",aString];
    
    return allString;
}

#pragma mark - 中文/字母/数字判断
+(BOOL)judegeCheseOrChart:(NSString *)str{
    BOOL isLetter = NO;
    NSString *testString = str;
    NSInteger alength = [str length];
    for (int i = 0; i<alength; i++) {
        char commitChar = [testString characterAtIndex:i];
        NSString *temp = [testString substringWithRange:NSMakeRange(i,1)];
        const char *u8Temp = [temp UTF8String];
        if (3==strlen(u8Temp)){//中文
            isLetter = NO;
        }else if((commitChar>64)&&(commitChar<91)){//大写英文字母
            isLetter = YES;
        }else if((commitChar>96)&&(commitChar<123)){//小写英文字母
            isLetter = YES;
        }else if((commitChar>47)&&(commitChar<58)){//数字
            isLetter = NO;
        }else{//非法字符
            isLetter = NO;
        }
    }
    return isLetter;
}

@end
