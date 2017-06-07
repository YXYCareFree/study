//
//  RightViewController.m
//  SliderController
//
//  Created by beyondSoft on 16/7/5.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "RightViewController.h"
#import "TestViewController.h"

@interface RightViewController ()

@end

@implementation RightViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    [self.navigationController setNavigationBarHidden:YES];
}
- (IBAction)rightBtn:(id)sender {

    TestViewController * test = [TestViewController new];

    [self.mmdVC closeDrawerAnimated:YES completion:nil];
    UINavigationController * nav = (UINavigationController *)self.mmdVC.centerViewController;
    //self.hidesBottomBarWhenPushed = YES;
    [nav pushViewController:test animated:YES];
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
