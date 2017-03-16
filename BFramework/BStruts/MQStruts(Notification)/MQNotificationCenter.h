//
//  MQNotificationCenter.h
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MQNotificationCenter : NSObject

+ (void)addObserver:(id)observer
           selector:(SEL)selector
               name:(NSNotificationName)name
             object:(id)object;

+ (void)removeObserver:(id)observer
                  name:(NSNotificationName)name
                object:(id)object;

+ (void)postNotificationName:(NSNotificationName)name
                      object:(id)object;

@end
