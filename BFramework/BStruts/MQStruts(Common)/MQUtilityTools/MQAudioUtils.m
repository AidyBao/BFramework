//
//  MQAudioUtils.m
//  YDHYK
//
//  Created by screson on 2016/12/26.
//  Copyright © 2016年 screson. All rights reserved.
//

#import "MQAudioUtils.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation MQAudioUtils

+ (void)vibrate{
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
}

@end
