//
//  ViewController.m
//  UISearchController
//
//  Created by beyondSoft on 16/9/23.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "SearchViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self performSelector:@selector(setNum) withObject:nil afterDelay:3];
}

- (void)setNum{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 3;
}
- (IBAction)search:(id)sender {

    SearchViewController * vc = [SearchViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
