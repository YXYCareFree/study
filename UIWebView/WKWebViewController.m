//
//  WKWebViewController.m
//  UIWebView
//
//  Created by 王小娜 on 2017/2/17.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import "WKWebViewController.h"
#import <WebKit/WebKit.h>

#define kScreenWidth       [UIScreen mainScreen].bounds.size.width
#define kScreenHeight      [UIScreen mainScreen].bounds.size.height

@interface WKWebViewController ()

@property (nonatomic, strong) WKWebView * wkWebView;
@property (weak, nonatomic) CALayer *progresslayer;

@end

@implementation WKWebViewController

- (void)dealloc{
    NSLog(@"\n***==%@: dealloc", NSStringFromClass([self class]));
    [self.wkWebView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"WKWebView";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.wkWebView];
    
    [self createProgressView];
    //http://180.76.185.85:9003/mall/account/toUserCenter.htm
    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://180.76.185.85:9003/mall/account/toUserCenter.htm"]]];
//    [_wkWebView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]]];
    
    [_wkWebView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];

}

- (void)createProgressView{
    
    UIView *progress = [[UIView alloc]initWithFrame:CGRectMake(0, 15, CGRectGetWidth(self.view.frame), 3)];
    progress.backgroundColor = [UIColor clearColor];
    [self.view addSubview:progress];
    
    CALayer *layer = [CALayer layer];
    layer.frame = CGRectMake(0, 0, 0, 3);
    layer.backgroundColor = [UIColor redColor].CGColor;
    [progress.layer addSublayer:layer];
    self.progresslayer = layer;
}
#pragma mark--设置进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context{
    
    if ([keyPath isEqualToString:@"estimatedProgress"]) {
        NSLog(@"%f", [change[NSKeyValueChangeNewKey] floatValue]);
        self.progresslayer.opacity = 1;
        self.progresslayer.frame = CGRectMake(0, 0, self.view.bounds.size.width * [change[NSKeyValueChangeNewKey] floatValue], 3);
        if ([change[NSKeyValueChangeNewKey] floatValue] == 1) {
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.opacity = 0;
            });
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                self.progresslayer.frame = CGRectMake(0, 0, 0, 3);
            });
        }
    }else{
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

- (WKWebView *)wkWebView{
    
    if (!_wkWebView) {
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, self.view.frame.size.height)];
//        _wkWebView.UIDelegate = self;
        // WKWebViewConfiguration * config = [[WKWebViewConfiguration alloc] init];
    }
    return _wkWebView;
}




@end
