//
//  ViewController.m
//  JSONModelTest
//
//  Created by beyondSoft on 16/3/24.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "MyModel.h"

@interface ViewController ()

@property (nonatomic, strong) MyModel * model;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys: @"yxy", @"myName", @"man",@"sex", nil];
    self.model = [[MyModel alloc] initWithDictionary:dic error:nil];
    NSLog(@"model=%@, dic = %@", self.model, dic);
    
//    MyModel * model1 = [[MyModel alloc] initWithString:@"{@"sex":@"man",@"myName":@"yxy"}" error:nil];
    NSString * str = [self.model toJSONString];
    NSLog(@"str=%@", str);
   // NSString * str = [self.model ];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
