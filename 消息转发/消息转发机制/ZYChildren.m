//
//  ZYChildren.m
//  消息转发机制
//
//  Created by zy on 16/5/4.
//  Copyright © 2016年 ZY. All rights reserved.
//

#import "ZYChildren.h"

@implementation ZYChildren

- (void)testMethod:(NSString *)str
{
    NSLog(@"%s", __func__);
}

- (void)newTestMethod:(NSString *)str
{
    NSLog(@"%s, %@", __func__, str);
}


@end
