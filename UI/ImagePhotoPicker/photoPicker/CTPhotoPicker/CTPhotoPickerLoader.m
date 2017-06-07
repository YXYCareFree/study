//
//  CTPhotoPickerLoader.m
//  SmartOA
//
//  Created by 冯增亮 on 15/10/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "CTPhotoPickerLoader.h"

static CTPhotoPickerLoader* _loader = nil;

@implementation CTPhotoPickerLoader

+(instancetype)sharedPhotoPickerLoader
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _loader = [[super allocWithZone:NULL] init];
    });
    return _loader;
}

+ (ALAssetsLibrary *)defaultAssetsLibrary
{
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    return library;
}

@end
