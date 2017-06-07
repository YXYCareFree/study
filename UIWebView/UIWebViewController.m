//
//  UIWebViewController.m
//  UIWebView
//
//  Created by 王小娜 on 2017/2/17.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import "UIWebViewController.h"

@interface UIWebViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation UIWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"UIWebView";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.webView];

    //http://180.76.185.85:9003/mall/account/toUserCenter.htm
    NSURLRequest * request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"http://180.76.185.85:9003/mall/account/toUserCenter.htm"]];
    [_webView loadRequest:request];
}

- (UIWebView *)webView{
    
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    }
    return _webView;
}


@end
