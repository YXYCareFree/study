//
//  ViewController.m
//  SheetView
//
//  Created by beyondSoft on 16/8/31.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "CustomSheetView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    CustomSheetView * sheetView = [CustomSheetView new];
    [sheetView show];
}
- (void)viewDidLoad {
    [super viewDidLoad];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
