//
//  ViewController.m
//  Localizations
//
//  Created by 王小娜 on 2017/3/1.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    UIButton * btn = [UIButton new];
    btn.backgroundColor = [UIColor redColor];
    btn.frame = CGRectMake(50, 50, 80, 40);
    btn.titleLabel.text = NSLocalizedString(@"title", nil);
    btn.titleLabel.textAlignment = NSTextAlignmentCenter;
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(share) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)share{
    
    NSString * text = @"要分享的内容";
    UIImage *img = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL           URLWithString:@"http://www.rooyeetone.com/img/platform01.png"]]];
    
    NSURL *url = [NSURL URLWithString:@"http://www.rooyeetone.com/platform.html"];
    
    NSArray * activityItems = @[text, img, url];
    
    UIActivityViewController * activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    [self presentViewController:activityVC animated:YES completion:nil];
    
    [activityVC setCompletionWithItemsHandler:^(NSString * activityType, BOOL completed, NSArray * returnedItems, NSError* activityError){
        
        NSLog(@"%@", activityType);
        if (completed) {
            NSLog(@"分享成功");
        }else NSLog(@"分享失败");
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
