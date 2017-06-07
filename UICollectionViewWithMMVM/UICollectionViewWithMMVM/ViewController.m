//
//  ViewController.m
//  UICollectionViewWithMMVM
//
//  Created by beyondSoft on 16/7/19.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "CollectionViewInteractor.h"
#import "CustomCollectionViewCell.h"

@interface ViewController ()

@property (nonatomic, strong) CollectionViewInteractor * interactor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUI];
}

- (void)setUI{

    _interactor = [CollectionViewInteractor new];
    _collectionView.dataSource = _interactor;
    _collectionView.delegate = _interactor;

    _collectionView.backgroundColor = [UIColor clearColor];
    [_collectionView registerNib:[UINib nibWithNibName:@"CustomCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@__STRING(CustomCollectionViewCell)];

    UICollectionViewFlowLayout * layout = [UICollectionViewFlowLayout new];
    layout.itemSize = CGSizeMake(80, 80);
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    _collectionView.collectionViewLayout = layout;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
