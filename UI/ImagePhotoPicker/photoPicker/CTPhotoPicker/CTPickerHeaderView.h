//
//  CTPickerHederView.h
//  SmartOA
//
//  Created by 冯增亮 on 15/10/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

typedef void(^sendAssets)(NSArray *assetArray);

@interface CTPickerHeaderView : UIView

@property (nonatomic, strong)    UICollectionView *collectionView;
@property (nonatomic, copy)      sendAssets sendAssets;
@property (nonatomic, strong)    NSMutableArray *assets;
@property (nonatomic, strong)    NSMutableArray *sendBackAssets;
@property (nonatomic, assign)    BOOL allowsMultiple;
@property (nonatomic, assign)    NSUInteger maxCount;

@end
