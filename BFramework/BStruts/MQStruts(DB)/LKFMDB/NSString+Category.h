//
//  NSString+Category.h
//  YDHYK
//
//  Created by 120v on 2016/12/5.
//  Copyright © 2016年 screson. All rights reserved.
//  获取汉字转成拼音字符串

#import <Foundation/Foundation.h>

@interface NSString (Category)
/** 
 *@prgram :将传入的aString转换为拼音字符串
 *@aString:传入的中文字符串
 */
+(NSString *)transformToPinyin:(NSString *)aString;

/**
 *@prgram:判断输入的str是中文/英文字母/大小写等
 */
+(BOOL)judegeCheseOrChart:(NSString *)str;

@end
