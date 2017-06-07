//
//  ViewController.m
//  UILabel
//
//  Created by beyondSoft on 16/9/8.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "UILabel+VerticalAlignment.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UILabel * verticalLabel = [[UILabel alloc] init];
//此方法可以设置label文字的竖直方向是靠上、居中、靠下属性
    [verticalLabel setTextVerticalAlignment:UITextVerticalAlignmentBottom];
    verticalLabel.text = @"test";
    verticalLabel.textAlignment = NSTextAlignmentCenter;
    verticalLabel.frame = CGRectMake(100, 100, 50, 50);
    verticalLabel.backgroundColor = [UIColor redColor];
    [self.view addSubview:verticalLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
