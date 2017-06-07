//
//  SecondViewController.m
//  Transition
//
//  Created by beyondSoft on 16/8/8.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "SecondViewController.h"
#import "UIViewController+XWTransition.h"
@interface SecondViewController ()

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor grayColor];

    UIButton * back = [[UIButton alloc] initWithFrame:CGRectMake(102, 220, 60, 60)];
    [back addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
    [back setTitle:@"dismiss" forState:UIControlStateNormal];
    [back setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:back];

    //使用抽屉效果时必须注册back手势，否则程序崩溃
    [self xw_registerBackInteractiveTransitionWithDirection:XWInteractiveTransitionGestureDirectionUp transitonBlock:^(CGPoint startPoint) {

    } edgeSpacing:0];
}


- (IBAction)dismiss:(id)sender {

    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
