//
//  YXYNavigationController.m
//  SliderController
//
//  Created by beyondSoft on 16/7/7.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "YXYNavigationController.h"
#import "LeftViewController.h"

@interface YXYNavigationController ()

@end

@implementation YXYNavigationController

- (void)viewDidLoad {
    [super viewDidLoad];

    //设置navigationBar的颜色
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];

//    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[UISplitViewController class]]] setBarTintColor:myColor];

   // [[UINavigationBar appearanceWhenContainedIn:[LeftViewController class], nil] setBarTintColor:[UIColor blackColor]];

}

//设置statusBar的颜色
- (UIStatusBarStyle)preferredStatusBarStyle{
   // return UIStatusBarStyleLightContent;
    return UIStatusBarStyleDefault;
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
