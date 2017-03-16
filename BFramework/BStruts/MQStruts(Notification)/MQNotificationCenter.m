//
//  MQNotificationCenter.m
//  YDHYK
//
//  Created by screson on 2016/11/28.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQNotificationCenter.h"

@implementation MQNotificationCenter


+ (NSNotificationCenter *)defaultCenter{
    return [NSNotificationCenter defaultCenter];
}

+ (void)addObserver:(id)observer selector:(SEL)selector name:(NSNotificationName)name object:(id)object{
    [[self defaultCenter] addObserver:observer selector:selector name:name object:object];
}

+ (void)removeObserver:(id)observer name:(NSNotificationName)name object:(id)object{
    [[self defaultCenter] removeObserver:observer name:name object:object];
}

+ (void)postNotificationName:(NSNotificationName)name object:(id)object{
    [[self defaultCenter] postNotificationName:name object:object];
}

@end
