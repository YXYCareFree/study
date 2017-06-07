//
//  MyTabBarController.m
//  UITabBarController
//
//  Created by beyondSoft on 16/3/23.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "MyTabBarController.h"
#import "ViewController.h"

@interface MyTabBarController ()

@end

@implementation MyTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor blackColor];
    ViewController * vc = [[ViewController alloc] init];
    vc.title = @"title";
    vc.view.backgroundColor = [UIColor redColor];
    ViewController * vc1 = [[ViewController alloc] init];
    vc1.view.backgroundColor = [UIColor grayColor];
    vc1.title = @"qwer";
    
    self.viewControllers = @[vc1,vc];
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
