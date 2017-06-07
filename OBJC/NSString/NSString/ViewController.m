//
//  ViewController.m
//  NSString
//
//  Created by beyondSoft on 16/8/31.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "TB_NSStringAdditions.h"//此文件有URLencode方法

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSString * str = @"12=123&23=23;99=00";
    //将str转化为字典,每一个键值对用&或;隔离
    NSDictionary * dic = [str tbQueryDictionaryUsingInnerInputCharsetEncoding];
    NSLog(@"\ndic = %@\n", dic);
    NSDictionary * dict = [str tbQueryContentsUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"\ndict = %@\n", dict);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
