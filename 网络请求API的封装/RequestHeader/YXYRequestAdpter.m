//
//  YXYRequestAdpter.m
//  AFNet
//
//  Created by beyondSoft on 16/8/25.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "YXYRequestAdpter.h"
#import "YXYGatewayApiService.h"
#import "YXYRequest.h"

@implementation YXYRequestAdpter

- (void)requestTestWithBaiDu{

    YXYRequest * request = [YXYRequest new];
    request.apiName = @"https://www.baidu.com/";

    request.success = ^(id success){

    };
    request.failure = ^(id failure){

    };
    YXYGatewayApiService  * gateway = [YXYGatewayApiService new];
    [gateway startRequest:request];
}

@end
