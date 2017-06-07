//
//  ViewController.m
//  UIAlertController
//
//  Created by beyondSoft on 16/3/25.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "MyViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (IBAction)btn:(id)sender {

    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"title" message:@"message" preferredStyle:UIAlertControllerStyleActionSheet];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];


//    MyViewController * myVC = [[MyViewController alloc] init];
//    myVC.view.backgroundColor = [UIColor blackColor];
//    [self presentViewController:myVC animated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
