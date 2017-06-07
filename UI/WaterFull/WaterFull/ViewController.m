//
//  ViewController.m
//  WaterFull
//
//  Created by beyondSoft on 16/7/28.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "DragView.h"

@interface ViewController ()<CHTCollectionViewDelegateWaterfallLayout, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
/**
 *  瀑布流item的大小
 */
@property (nonatomic, strong) NSArray * cellSizeArr;

@property (nonatomic, strong) UIWindow * window;
/**
 *  可拖拽的View
 */
@property (nonatomic, strong) DragView * dragView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initCollectionView];

    _dragView = [[DragView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    _dragView.backgroundColor = [UIColor redColor];
    _dragView.layer.cornerRadius = 30;
    [self.view addSubview:_dragView];
    
    //[self performSelector:@selector(initWindow) withObject:nil afterDelay:0.1];
}

- (void)initWindow{

    _window = [[UIWindow alloc] initWithFrame:CGRectMake(30, 100, 60, 60)];
    _window.layer.cornerRadius = 30;
    _window.backgroundColor = [UIColor redColor];
    _window.windowLevel = UIWindowLevelAlert;
    _window.alpha = 0.5;
    [_window makeKeyAndVisible];

    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
    [btn setTitle:@"test" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor grayColor]];
    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [_window addSubview:btn];
}

- (void)btnClicked:(id)sender{

    [_collectionView removeFromSuperview];
    
}

- (void)initCollectionView{

    CHTCollectionViewWaterfallLayout * layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.minimumColumnSpacing = 20;
    layout.minimumInteritemSpacing = 20;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);

    _collectionView.collectionViewLayout = layout;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
}

#pragma mark--UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    CGFloat r = arc4random_uniform(255);
    CGFloat g = arc4random_uniform(255);
    CGFloat b = arc4random_uniform(255);

    NSInteger i = indexPath.row % 4 + 1;
    cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"cat%ld.jpg", i]]];
    cell.backgroundColor = [UIColor colorWithRed:r/255 green:g/255 blue:b/255 alpha:1.0];
    return cell;
}

#pragma mark--CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    // NSLog(@"%@", NSStringFromCGSize([self.cellSizeArr[indexPath.item % 4] CGSizeValue]));
    return [self.cellSizeArr[indexPath.item % 4] CGSizeValue];
}

- (NSArray *)cellSizeArr{

    if (_cellSizeArr == nil) {

        _cellSizeArr = @[[NSValue valueWithCGSize:CGSizeMake(200, 300)],
                         [NSValue valueWithCGSize:CGSizeMake(500, 700)],
                         [NSValue valueWithCGSize:CGSizeMake(100, 200)],
                         [NSValue valueWithCGSize:CGSizeMake(450, 600)]];
//        _cellSizeArr = @[
//                         [NSValue valueWithCGSize:CGSizeMake(400, 550)],
//                         [NSValue valueWithCGSize:CGSizeMake(1000, 665)],
//                         [NSValue valueWithCGSize:CGSizeMake(1024, 689)],
//                         [NSValue valueWithCGSize:CGSizeMake(640, 427)]
//                         ];
    }
    return _cellSizeArr;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
