//
//  CTPhotoPickerLoader.h
//  SmartOA
//
//  Created by 冯增亮 on 15/10/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AssetsLibrary/AssetsLibrary.h>

@interface CTPhotoPickerLoader : NSObject

@property(nonatomic,strong)NSArray *imageArray;

+(instancetype)sharedPhotoPickerLoader;

+(ALAssetsLibrary *)defaultAssetsLibrary;

@end
