//
//  PhoneViewController.m
//  DragView
//
//  Created by beyondSoft on 16/8/23.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "PhoneViewController.h"

@interface PhoneViewController ()

@end

@implementation PhoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];
    UIButton * backBtn = [[UIButton alloc] initWithFrame:CGRectMake(60, 200, 60, 60)];
    [backBtn setTitle:@"back" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)back:(UIButton *)btn{

    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
