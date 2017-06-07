//
//  HomeViewController.m
//  MVC
//
//  Created by beyondSoft on 16/4/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeViewControllerInteractor.h"

@interface HomeViewController ()

@property (nonatomic, strong)HomeViewControllerInteractor * interactor;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _interactor = [HomeViewControllerInteractor new];
    _interactor.homeVC = self;
    self.tableView.delegate = _interactor;
    self.tableView.dataSource = _interactor;
    _interactor.dataSource = @[@"qwe", @"ewq"];
    
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
