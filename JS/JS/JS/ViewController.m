//
//  ViewController.m
//  JS
//
//  Created by beyondSoft on 16/5/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "TestJSObject.h"

@interface ViewController ()<UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1/index2.html"]]];


}
- (IBAction)btn:(id)sender {
//    NSString *currentURL = [webView stringByEvaluatingJavaScriptFromString:@"document.location.href"];
//}

//    NSString *js_result = [_webView stringByEvaluatingJavaScriptFromString:@"document.getElementsByName('q')[0].value='朱祁林';"];
//
//
//    NSString *js_result2 = [_webView stringByEvaluatingJavaScriptFromString:@"document.forms[0].submit(); "];

    JSContext * context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    NSString * str1 = @"1";
    NSString * str2 = @"2";
    [context evaluateScript:[NSString stringWithFormat:@"postStr('%@','%@');",str1,str2]];
    NSString * str = [self.webView stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"postStr('%@','%@');",str1,str2]];;
    NSLog(@"**%@", str);
}

- (void)webViewDidFinishLoad:(UIWebView *)webView{

    JSContext * context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    TestJSObject * test = [TestJSObject new];
    context[@"testobject"] = test;

    NSString * jsStr1 = @"testobject.TestNoParameter()";

    [context evaluateScript:jsStr1];

    NSString * jsStr2 = @"testobject.TestOneParameter('参数22')";
    [context evaluateScript:jsStr2];
    
    context[@"test1"] = ^() {

        NSArray * arr = [JSContext currentArguments];
        for (id obj in arr) {
            NSLog(@"%@", obj);
        }
    };
//    NSString * jsFunStr = @"test1('参数1')";
//   // NSString * alertJS = @"alert('test js OC')";
//    [context evaluateScript:jsFunStr];
//
//    NSString * jsFun = @"test1('参数a', '参数b')";
//    [context evaluateScript:jsFun];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
