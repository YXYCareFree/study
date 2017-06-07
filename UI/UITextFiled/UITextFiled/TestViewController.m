//
//  TestViewController.m
//  UITextFiled
//
//  Created by beyondSoft on 16/5/31.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "TestViewController.h"
#import "ViewController.h"

@interface TestViewController ()

@end

@implementation TestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    ViewController * vc = [ViewController new];
    vc.enumTest = Online_Env;
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
