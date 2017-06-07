//
//  ViewController.m
//  UIView
//
//  Created by beyondSoft on 16/9/8.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

//此处的宏定义可以解决mas_前缀的问题使equalTo与mas_equalTo等价
#define MAS_SHORTHAND
#define MAS_SHORTHAND_GLOBALS

#import "ViewController.h"
#import "UIView+Quartz.h"
#import "Masonry.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    UIView *redView = [[UIView alloc] init];
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
     // 蓝色
    UIView *blueView= [[UIView alloc] init];
    blueView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:blueView];
    // 黑色
     UIView *blackView = [[UIView alloc] init];
     blackView.backgroundColor = [UIColor blackColor];
    [self.view addSubview:blackView];
     // 绿色
     UIView *greenView= [[UIView alloc] init];
     greenView.backgroundColor = [UIColor greenColor];
     [self.view addSubview:greenView];


         // autolayout
   __weak typeof(self) weakSelf = self;
    [redView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.centerX.equalTo(weakSelf.view).offset(-30);
        make.centerY.equalTo(weakSelf.view).offset(-30);
        make.size.equalTo(CGSizeMake(60, 60));
        //make.top.offset(90);

    }];

    [blueView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.equalTo(redView.right).offset(10);

//        make.height.equalTo(weakSelf.view);//没有指定width和height的情况下设置的是什么就以什么为准
//        make.width.equalTo(weakSelf.view).dividedBy(3);
        make.size.equalTo(CGSizeMake(60, 60));
        make.centerY.equalTo(redView);
    }];

    [blackView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.size.equalTo(CGSizeMake(60, 60));

        make.top.equalTo(redView.bottom).offset(10);
        make.centerX.equalTo(redView);
    }];

    [greenView mas_makeConstraints:^(MASConstraintMaker *make) {

        make.size.equalTo(CGSizeMake(60, 60));
        make.centerX.equalTo(blueView);
        make.centerY.equalTo(blackView);
    }];

}




@end
