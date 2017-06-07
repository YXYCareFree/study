//
//  ViewController.m
//  testJSPath
//
//  Created by beyondSoft on 16/7/25.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "SecondViewController.h"
//#import "AppDelegate.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView * tableView;
@property (nonatomic, strong) NSArray * data;
//@property (nonatomic, strong) AppDelegate * app;
@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];

}

- (void)viewDidLoad {
    [super viewDidLoad];

//    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(300, 300, 90, 90)];
//    btn.backgroundColor = [UIColor redColor];
//    [btn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:btn];


    [self.view addSubview:self.tableView];

    //_app = [UIApplication sharedApplication].delegate;
   // [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@""]];

    _data = [NSArray new];
    _data = @[@"1", @"2", @"3"];
}

- (void)openUrl:(NSURL *)url{
    
    if ([[UIApplication sharedApplication] canOpenURL:url]) {

        [[UIApplication sharedApplication] openURL:url];
    }

}

- (UITableView *)tableView{

    if (_tableView == nil) {

        _tableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];

        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}
- (void)btnClicked{

    NSLog(@"dianjile");
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * reuse = @"cell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuse];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }
    cell.textLabel.text = @"test";
    
    return cell;
}

#pragma mark--UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    SecondViewController * vc = [SecondViewController new];
    [self.navigationController pushViewController:vc animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
