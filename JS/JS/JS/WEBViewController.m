//
//  WEBViewController.m
//  JS
//
//  Created by beyondSoft on 16/5/12.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "WEBViewController.h"
#import "WebViewJavascriptBridge.h"

@interface WEBViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic, strong) WebViewJavascriptBridge * bridge;
@end

@implementation WEBViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _webView.delegate = self;
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1/index2.html"]]];
    self.bridge = [WebViewJavascriptBridge bridgeForWebView:self.webView];

    //js调用oc方法，点击h5页面的button触发
    [self.bridge registerHandler:@"JSCallOC" handler:^(id data, WVJBResponseCallback responseCallback) {
        NSLog(@"JSCallOC:%@", data);
        responseCallback(@"Response from JSCallOC");
    }];

    //oc调用js方法
    //[self.bridge callHandler:@"OCCallJS" data:@{@"OCCallJS":@"yes"}];
    [self.bridge callHandler:@"OCCallJS" data:@{@"OCCallJS":@"success"} responseCallback:^(id responseData) {
        NSLog(@"ocReceived:%@", responseData);
    }];


   // [self performSelector:@selector(OCCallJS) withObject:nil afterDelay:3];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{



}

- (void)OCCallJS{

    NSLog(@"%s", __FUNCTION__);
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(OCAndJS) userInfo:nil repeats:YES];
    [timer fire];
}

- (void)OCAndJS{
    [self.bridge callHandler:@"OCCallJS" data:@{@"OCCallJS":@"success"} responseCallback:^(id responseData) {
        NSLog(@"OCCallJS:%@", responseData);
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
