//
//  ViewController.m
//  SafeStorage
//
//  Created by beyondSoft on 16/8/1.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "YXYSafeStorage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YXYSafeStorage * storage = [YXYSafeStorage shareSafeStorage];
    NSDictionary * dic = @{@"111":@"222", @"qwe":@"qwert"};
    [storage saveObject:dic forKey:@"key1"];
    NSLog(@"%@", [storage objectForKey:@"key1"]);
    NSLog(@"%@", [storage objectForKey:@""]);

    [storage removeObjectForKey:@"key1"];
    NSLog(@"%@", [storage objectForKey:@"key1"]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
