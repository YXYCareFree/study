//
//  CTPickerHederView.m
//  SmartOA
//
//  Created by 冯增亮 on 15/10/28.
//  Copyright © 2015年 Alibaba. All rights reserved.
//

#import "CTPickerHeaderView.h"

#import "CTPhotoPickerLoader.h"
#import "CTCommonUI.h"
//#import "Localization.h"

@interface CTPickerHeaderView()<UICollectionViewDataSource, UICollectionViewDelegate>

@end

@implementation CTPickerHeaderView

- (id)init{
    self = [super init];
    if (self) {
        self.allowsMultiple = NO;
        [self initHeaderView];
        [self getCameraRollImages];
    }
    return self;
}


- (void)initHeaderView {
    self.frame = CGRectMake(0, 0, CGRectGetWidth([UIScreen mainScreen].bounds), 190);
    UICollectionViewFlowLayout *aFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    [aFlowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 190) collectionViewLayout:aFlowLayout];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.showsVerticalScrollIndicator = NO;
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"Cell"];
    [self addSubview:self.collectionView];
}

#pragma mark - Collection view

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return MIN(20, self.assets.count);
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    
//    [collectionView removeSubviews];
    ALAsset *asset = self.assets[self.assets.count - 1 - indexPath.row];
    
    ALAssetRepresentation* representation = [asset defaultRepresentation];
    CGSize dimension = [representation dimensions];
    
    UIImageView *imageView = nil;
    UIImageView *selectImageView = nil;
    if ([cell.contentView viewWithTag:999]) {
        imageView = (UIImageView *)[cell.contentView viewWithTag:999];
        selectImageView = (UIImageView *)[cell.contentView viewWithTag:998];
    } else {
        imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        imageView.clipsToBounds = YES;
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        imageView.tag = 999;
        [cell.contentView addSubview:imageView];
        
        selectImageView = [[UIImageView alloc] initWithImage:CommonUILoadImage(@"checkmark2")];
        selectImageView.clipsToBounds = YES;
        selectImageView.contentMode = UIViewContentModeScaleAspectFill;
        selectImageView.tag = 998;
        [cell.contentView addSubview:selectImageView];
    }
    imageView.frame = CGRectMake(10, 5, dimension.width/(dimension.height/170.f), 170.f);
    imageView.image = [UIImage imageWithCGImage:asset.aspectRatioThumbnail];
    
    if ([self.sendBackAssets indexOfObject:asset] == NSNotFound) {
        selectImageView.image = CommonUILoadImage(@"checkmark1");
    }else{
        selectImageView.image = CommonUILoadImage(@"checkmark2");
    }
    selectImageView.center = CGPointMake(imageView.bounds.size.width - 5, imageView.bounds.origin.y + 20);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    ALAsset *asset = self.assets[self.assets.count - 1 - indexPath.row];
    if ([self.sendBackAssets indexOfObject:asset] == NSNotFound) {
        if (!self.allowsMultiple) {
            [self.sendBackAssets removeAllObjects];
        }
        
        if (self.sendBackAssets.count >= self.maxCount) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil message:@"照片数达到限制" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alertView show];
            return;
        }
        [self.sendBackAssets addObject:asset];
    }else{
        [self.sendBackAssets removeObject:asset];
    }
    
    self.sendAssets(self.sendBackAssets);
    [self.collectionView reloadData];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
        if (cell) {
            CGRect bounds = collectionView.bounds;
            CGRect rect = CGRectMake(cell.center.x - bounds.size.width / 2, 0, bounds.size.width, bounds.size.height);
            [collectionView scrollRectToVisible:rect animated:YES];
        }
    });

    
//    ALAsset *asset = self.assets[self.assets.count - 1 - indexPath.row];
//    ALAssetRepresentation* representation = [asset defaultRepresentation];
//    UIImageOrientation orientation = UIImageOrientationUp;
//    NSNumber* orientationValue = [asset valueForProperty:@"ALAssetPropertyOrientation"];
//    if (orientationValue != nil) {
//        orientation = [orientationValue intValue];
//    }
//    
//    CGFloat scale  = 1;
//    UIImage* image = [UIImage imageWithCGImage:[representation fullResolutionImage]
//                                         scale:scale orientation:orientation];
    
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    ALAsset *asset = self.assets[self.assets.count - 1 - indexPath.row];
    
    ALAssetRepresentation* representation = [asset defaultRepresentation];
    CGSize dimension = [representation dimensions];
    float width = dimension.width;
    float height = dimension.height;
    return CGSizeMake(width/(height/170.f)+10.f, 190.f);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 10.0f;
}

#pragma mark - Image library
- (void)getCameraRollImages {
    _sendBackAssets = [NSMutableArray array];
    _assets = [NSMutableArray array];

    dispatch_queue_t dispatchQueue =dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(dispatchQueue, ^(void) {
        // 遍历所有相册
        
        // Block called for every asset selected
        void (^selectionBlock)(ALAsset*, NSUInteger, BOOL*) = ^(ALAsset* asset,
                                                                NSUInteger index,
                                                                BOOL* innerStop) {
            // The end of the enumeration is signaled by asset == nil.
            if (asset == nil) {
                return;
            }
            
            dispatch_async(dispatch_get_main_queue(), ^(void) {
                [self.assets addObject:asset];
                [self.collectionView reloadData];
            });
        };
        // Block called when enumerating asset groups
        void (^enumerationBlock)(ALAssetsGroup*, BOOL*) = ^(ALAssetsGroup* group, BOOL* stop) {
            // Within the group enumeration block, filter to enumerate just photos.
            [group setAssetsFilter:[ALAssetsFilter allPhotos]];
            // Get the photos at the last index
            NSInteger len = MIN(group.numberOfAssets, 20);
            NSIndexSet* photoIndexSet = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(group.numberOfAssets - len, len)];
            [group enumerateAssetsAtIndexes:photoIndexSet options:0 usingBlock:selectionBlock];
        };
        // Enumerate just the photos and videos group by using ALAssetsGroupSavedPhotos.
        [[CTPhotoPickerLoader defaultAssetsLibrary] enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos
                               usingBlock:enumerationBlock
                             failureBlock:^(NSError* error) {
                                 NSLog(@"Failed to enumerate the asset groups.");
                             }];
    });
}

@end