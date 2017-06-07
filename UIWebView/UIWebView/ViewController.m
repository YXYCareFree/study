//
//  ViewController.m
//  UIWebView
//
//  Created by 王小娜 on 2017/2/17.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import "ViewController.h"
#import "WKWebViewController.h"
#import "UIWebViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton * wkBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 80, 140, 40)];
    [wkBtn addTarget:self action:@selector(wkWebView) forControlEvents:UIControlEventTouchUpInside];
    [wkBtn setTitle:@"WKWebView" forState:UIControlStateNormal];
    [wkBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:wkBtn];
    
    UIButton * uiBtn = [[UIButton alloc] initWithFrame:CGRectMake(180, 80, 140, 40)];
    [uiBtn addTarget:self action:@selector(uiWebView) forControlEvents:UIControlEventTouchUpInside];
    [uiBtn setTitle:@"UIWebView" forState:UIControlStateNormal];
    [uiBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:uiBtn];
}


- (void)wkWebView{
    
    WKWebViewController * wk = [WKWebViewController new];
    [self.navigationController pushViewController:wk animated:YES];
}

- (void)uiWebView{
    UIWebViewController * web = [UIWebViewController new];
    [self.navigationController pushViewController:web animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
