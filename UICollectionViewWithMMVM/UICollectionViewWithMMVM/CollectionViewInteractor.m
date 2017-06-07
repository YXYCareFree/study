//
//  CollectionViewInteractor.m
//  UICollectionViewWithMMVM
//
//  Created by beyondSoft on 16/7/19.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "CollectionViewInteractor.h"
#import "CustomCollectionViewCell.h"

@implementation CollectionViewInteractor

#pragma mark--UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CustomCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@__STRING(CustomCollectionViewCell) forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}

#pragma mark--UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"****");
}
@end
