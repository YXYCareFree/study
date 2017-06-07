//
//  UITableViewAnimationController.m
//  UITableViewCellAnimation
//
//  Created by beyondSoft on 16/9/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "UITableViewAnimationController.h"
#import "CustomTableViewCell.h"
#import "UIImageView+Additional.h"

@interface UITableViewAnimationController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic)  UITableView *tableView;

@end

@implementation UITableViewAnimationController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor whiteColor];

    //[self.tableView registerClass:[CustomTableViewCell class] forCellReuseIdentifier:@"cellId"];
    [self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"cellId"];
    [self.view addSubview:self.tableView];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

}

#pragma mark--UITableViewDataSourceDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   // return self.dataSource.count;
    return 200;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"cellId";
    CustomTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID ];
    if (cell == nil) {
        cell = [[CustomTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        //cell = [[NSBundle mainBundle] loadNibNamed:@"CustomTableViewCell" owner:nil options:nil][0];
    }

    cell.bgImageView.image = cell.imageView2.image = cell.imageView1.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld.jpg", indexPath.row % 4]];
    cell.bgImageView.layer.cornerRadius = cell.imageView1.layer.cornerRadius = cell.imageView2.layer.cornerRadius = 25;
    cell.bgImageView.layer.masksToBounds = cell.imageView1.layer.masksToBounds = cell.imageView2.layer.masksToBounds = YES;
    
    
//    [cell.imageView1 setCorner:25];
//    [cell.bgImageView setCorner:25];
//    [cell.imageView2 setCorner:25];
    
    return cell;
}

#pragma mark--UITableViewDelegate
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath{
//    [self doAnimationWithCellAnimationStyle:self.cellAnimationStyle onTheView:cell];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
#pragma mark--UITableViewCellAnimation
- (void)doAnimationWithCellAnimationStyle:(UITableViewCellAnimationStyle)style onTheView:(UIView *)view{

    switch (style) {

        case UITableViewCellAnimationStylePosition:
        {
            view.transform = CGAffineTransformTranslate(view.transform, -[UIScreen mainScreen].bounds.size.width, 0);
            [UIView animateWithDuration:0.5 animations:^{
                view.transform = CGAffineTransformIdentity;
            }];
        }
            break;

        case UITableViewCellAnimationStyleFade:
        {
            view.alpha = 0;
            [UIView animateWithDuration:1 animations:^{
                view.alpha = 1;
            }];
        }
            break;

        case UITableViewCellAnimationStyleRotateX:
        {
            view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 1, 0, 0);
            [UIView animateWithDuration:0.5 animations:^{
                view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 1, 0, 0);
            }];
        }
            break;

        case UITableViewCellAnimationStyleRotateY:
        {
            view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 0, 1, 0);
            [UIView animateWithDuration:0.5 animations:^{
                view.layer.transform = CATransform3DRotate(view.layer.transform, M_PI, 0, 1, 0);
            }];
        }
            break;

        case UITableViewCellAnimationStyleScale:
        {
            view.layer.transform = CATransform3DMakeScale(0.2, 0.2, 1);
            [UIView animateWithDuration:0.5 animations:^{
                view.layer.transform = CATransform3DMakeScale(1, 1, 1);
            }];
        }
            break;
        default:
            break;
    }
}

- (UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
    }
    return _tableView;
}

@end
