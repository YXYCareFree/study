//
//  ViewController.m
//  AFNet
//
//  Created by beyondSoft on 16/5/9.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "YXYHTTPRequestClient.h"
#import "YXYRequestAdpter.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    YXYRequestAdpter * adpter = [YXYRequestAdpter new];
    [adpter requestTestWithBaiDu];

    
//    YXYHTTPRequestClient * client = [YXYHTTPRequestClient shareManager];
//
//   [client postPath:@"/www.baidu.com" apiVersion:@"" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
//
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        NSLog(@"%@\n\n%@", operation.request.URL, operation.responseString);
//    }];
   // [client.operationQueue cancelAllOperations];
   // [operation cancel];
//    [operation pause];
//    [operation resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
