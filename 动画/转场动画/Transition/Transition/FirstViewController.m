//
//  FirstViewController.m
//  Transition
//
//  Created by beyondSoft on 16/8/8.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "FirstViewController.h"
#import "SecondViewController.h"
#import "UINavigationController+XWTransition.h"
#import "UIViewController+XWTransition.h"
#import "XWCircleSpreadAnimator.h"
#import "CollectionViewCell.h"
#import "FlowLayout.h"
#import "XWMagicMoveAnimator.h"
#import "MagicViewController.h"
#import "XWCoolAnimator.h"
#import "XWDrawerAnimator.h"

@interface FirstViewController ()<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) NSArray * dataSource;
@end

@implementation FirstViewController

- (IBAction)draw:(id)sender {

    //使用抽屉效果时必须在下一个界面注册back手势否则会导致程序崩溃
    XWDrawerAnimator * animator = [XWDrawerAnimator xw_animatorWithDirection:XWDrawerAnimatorDirectionLeft moveDistance:300];
    /**视差效果，类似于QQ的设置界面弹出效果, 和flipEnable只能选择其一，如果都设置为YES，后设置的生效*/
    animator.parallaxEnable = YES;
    /**翻转效果，类似于淘宝选择规格时，后面视图的动画效果*/
    animator.flipEnable = YES;
    animator.toDuration = 0.5f;
    animator.backDuration = 0.5f;

    SecondViewController * vc = [SecondViewController new];
    //[self.navigationController xw_pushViewController:vc withAnimator:animator];
    [self xw_presentViewController:vc withAnimator:animator];
    __weak typeof(self) weakSelf = self;

    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{

        [weakSelf back];
    }];
}

- (void)back{

    if (self.presentedViewController) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)PageBtn:(id)sender {
//改变type可以改变相应的动画效果
    XWCoolAnimator * animator = [XWCoolAnimator xw_animatorWithType:8];
    animator.toDuration = 1.0f;
    animator.backDuration = 1.0f;

    SecondViewController * vc = [SecondViewController new];
    [self xw_presentViewController:vc withAnimator:animator];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.collectionView registerNib:[UINib nibWithNibName:@"CollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cell"];

    FlowLayout * layout = [FlowLayout new];
    self.collectionView.collectionViewLayout = layout;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    CollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.dataSource[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    MagicViewController * vc = [MagicViewController new];
    vc.index = indexPath.item;
    __weak typeof(self)weakSelf = self;

//点击展示图片的block回调方法
    vc.dismissConfig = ^(NSIndexPath * indexPath){

        [weakSelf dismiss:indexPath];
    };

    CollectionViewCell * cell = (CollectionViewCell *)[self.collectionView cellForItemAtIndexPath:indexPath];
    //注册神奇移动转场起始和终止视图
    [self xw_addMagicMoveStartViewGroup:@[cell]];

    XWMagicMoveAnimator * animator = [XWMagicMoveAnimator new];
    cell.magicMoveImageMode = YES;

    [self xw_presentViewController:vc withAnimator:animator];
}

- (void)dismiss:(NSIndexPath *)indexPath{

    CollectionViewCell * cell = (CollectionViewCell *)[_collectionView cellForItemAtIndexPath:indexPath];
    //更改转场视图为collectionView滑动的视图
    [self xw_changeMagicMoveStartViewGroup:@[cell]];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (NSArray *)dataSource{

    if (_dataSource == nil) {
        _dataSource = @[@"1.jpg", @"2.jpg", @"3.jpg", @"4.jpg", @"5.jpg", @"6.jpg"];
    }
    return _dataSource;
}

- (IBAction)btn:(id)sender {

    SecondViewController * vc = [[SecondViewController alloc] init];

    XWCircleSpreadAnimator *animator = [XWCircleSpreadAnimator xw_animatorWithStartCenter:self.button.center radius:20];
    [self.navigationController xw_pushViewController:vc withAnimator:animator];
    //[self xw_presentViewController:vc withAnimator:animator];
}

@end
