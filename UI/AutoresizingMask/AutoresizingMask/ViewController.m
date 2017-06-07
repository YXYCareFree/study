//
//  ViewController.m
//  AutoresizingMask
//
//  Created by beyondSoft on 16/7/1.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    UIView * redView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 100)];
    redView.backgroundColor = [UIColor redColor];

    UIView * blackView = [UIView new];
    [blackView setBackgroundColor:[UIColor blackColor]];
    [blackView setFrame:CGRectMake(30, 30, 50, 50)];
    [redView addSubview:blackView];
    blackView.autoresizingMask = UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;

    [self.view addSubview:redView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
