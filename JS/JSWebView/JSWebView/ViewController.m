//
//  ViewController.m
//  JSWebView
//
//  Created by beyondSoft on 16/3/25.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "WebViewJavascriptBridge.h"

@interface ViewController ()<UIWebViewDelegate>
@property (nonatomic, strong) WebViewJavascriptBridge * bridge;
@property (nonatomic, strong) UIWebView * webView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:self.webView];
    self.webView.delegate = self;

    [self initJSBridge];

}

- (void)initJSBridge{

    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];
    [self.bridge registerHandler:@"ocCallJS" handler:^(id data, WVJBResponseCallback responseCallback) {

        NSLog(@"ocCallJS==%@", data);
    }];


    [self.bridge callHandler:@"JSCallOc" data:@"" responseCallback:^(id responseData) {

        NSLog(@"JSCallOc");
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        NSURLRequest * request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1:8080/Desktop/index3.html"]];
        [self.webView loadRequest:request];

        [_bridge callHandler:@"ocCallJS" data:@"ocCallJS" responseCallback:^(id responseData) {

            NSLog(@"ocCallJS");
        }];
    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
