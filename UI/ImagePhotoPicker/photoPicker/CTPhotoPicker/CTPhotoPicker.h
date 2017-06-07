//
//  CTPhotoPicker.h
//  SmartOA
//
//  Created by 冯增亮 on 15/10/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CTPhotoPickerDelegate <NSObject>

//选取照片回调
- (void)photoPicker:(id)picker didFinishPickingAssets:(NSArray *)assets theOriginal:(BOOL)theOriginal;

//拍照片回调
- (void)photoPicker:(id)picker didFinishPickingImages:(NSArray *)images;

//取消图片选择
- (void)didCancelPickingImages:(id)picker;

@end

@interface CTPhotoPicker : NSObject

@property (nonatomic, assign) BOOL allowsEditing;

@property (nonatomic, assign) BOOL allowsMultiple;

@property (nonatomic, assign) BOOL useFrontCamera;

@property (nonatomic, assign) NSUInteger maxCount;

@property(nonatomic, weak) id<CTPhotoPickerDelegate> delegate;

@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;

@property (nonatomic, weak) id context;

- (void)show;

- (void)showInVC:(UIViewController *)vc;

- (void)dismiss;

@end
