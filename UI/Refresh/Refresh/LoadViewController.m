//
//  LoadViewController.m
//  Refresh
//
//  Created by beyondSoft on 16/6/29.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "LoadViewController.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"
#import "JGProgressHUD.h"

@interface LoadViewController ()

@property (nonatomic, strong) MBProgressHUD * hud;

@property (nonatomic, strong) JGProgressHUD * jgHud;

@end

@implementation LoadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self loadData];

}

- (void)loadData{

    _jgHud = [JGProgressHUD progressHUDWithStyle:JGProgressHUDStyleLight];
    CGRect  rect = [[UIScreen mainScreen]bounds];
    _jgHud.textLabel.text = @"正在加载...";
    [_jgHud showInRect:rect inView:self.view];

    AFHTTPSessionManager * manager = [AFHTTPSessionManager manager];
    NSMutableSet *contentTypes = [[NSMutableSet alloc] initWithSet:manager.responseSerializer.acceptableContentTypes];
    [contentTypes addObject:@"text/html"];//添加类型
    manager.responseSerializer.acceptableContentTypes = contentTypes;

    [manager GET:@"http://c.m.163.com/nc/article/BQO7KT7100963VRO/full.html" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

          [_jgHud dismissAnimated:YES];

       } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

         NSLog(@"ERROR == %@", error);
     }];
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
