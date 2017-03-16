//
//  NSString+ZXRemoveEmoji.h
//  YDHYK
//
//  Created by 120v on 2017/2/24.
//  Copyright © 2017年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (ZXRemoveEmoji)

- (BOOL)isIncludingEmoji;

- (instancetype)removedEmojiString;

- (instancetype) removeEmojiAtTheEnd;

@end
