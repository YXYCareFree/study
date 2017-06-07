//
//  CTSoundUtil.m
//  SmartOA
//
//  Created by 冯增亮 on 15/10/30.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "CTSoundUtil.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation CTSoundUtil

+ (void)soundTip{
    NSString *path = [NSString stringWithFormat:@"/System/Library/Audio/UISounds/%@.%@",@"sms-received1",@"caf"];
    if (path) {
        SystemSoundID sound;
        AudioServicesCreateSystemSoundID((__bridge CFURLRef)[NSURL fileURLWithPath:path],&sound);
        //跟系统保持一致
        AudioServicesPlayAlertSound(sound);
    }
}

@end
