//
//  MagicViewController.m
//  Transition
//
//  Created by beyondSoft on 16/8/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "MagicViewController.h"
#import "UIViewController+XWTransition.h"

@interface MagicViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, strong) UIView * tempView;
@end

@implementation MagicViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //转场结束后，要隐藏临时视图，同时显示collectionView，转场完成
    _tempView.hidden = YES;
    _collectionView.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];
    [self initMagicView];
}

- (void)initMagicView{

    //注意：由于在转场过程中cell还没有加载，所以无法注册cell为神奇移动视图，这种情况需要生产一个零时视图注册为转场视图来使用
    _tempView = [UIView new];
    //设置临时视图的图片和位置与cell完全重合
    _tempView.layer.contents = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"%lu.jpg", _index + 1]].CGImage;
    _tempView.center = self.view.center;
    _tempView.bounds = CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetWidth(self.view.bounds));
    [self.view addSubview:_tempView];
    //将临时视图注册为神奇移动结束视图
    [self xw_addMagicMoveEndViewGroup:@[_tempView]];

    _collectionView.hidden = YES;
}

- (void)initUI{

    self.view.backgroundColor = [UIColor blackColor];

    UICollectionViewFlowLayout * flowLayout = [UICollectionViewFlowLayout new];
    flowLayout.itemSize = CGSizeMake(self.view.frame.size.width, self.view.frame.size.width);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;

    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    _collectionView.backgroundColor = [UIColor blackColor];
    _collectionView.pagingEnabled = YES;
    _collectionView.delegate = self;
    _collectionView.dataSource = self;

    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"reuseCell"];
    _collectionView.center = self.view.center;
    _collectionView.bounds = CGRectMake(0, 0, flowLayout.itemSize.width, flowLayout.itemSize.height);
    [self.view addSubview:_collectionView];

    //根据点击的index设置collectionView的滚动位置
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:_index inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 6;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"reuseCell" forIndexPath:indexPath];
    cell.layer.contents = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"%lu.jpg", indexPath.item + 1]].CGImage;
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    _tempView.hidden = NO;
    _collectionView.hidden = YES;

    _tempView.layer.contents = (__bridge id)[UIImage imageNamed:[NSString stringWithFormat:@"%lu.jpg", indexPath.item + 1]].CGImage;
    if (_dismissConfig) {
        _dismissConfig(indexPath);
    }
}

@end
