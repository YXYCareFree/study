//
//  ViewController.m
//  Dispatch_queue
//
//  Created by 王小娜 on 2017/2/23.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    //[self handleRunLoopWithGCD];//循环的执行999次，同步执行大概用时330ms 异步执行大概用时410ms
    //[self handleRunLoopWithForIn];//循环的执行999次，大概用时530ms
    
    [self createCrashWithGCD];//造成死锁
}

- (void)handleRunLoopWithGCD{
    
    int count = 999;//循环的执行次数
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    dispatch_async(queue, ^{
        
        dispatch_apply(count, queue, ^(size_t i) {
            NSLog(@"%zu",i);
        });
    });
//    dispatch_apply(count, queue, ^(size_t i) {
//        NSLog(@"%zu",i);
//    });
    NSLog(@"*******");
}

- (void)handleRunLoopWithForIn{
    
    int count = 999;//大概用时560ms
    for (int i = 0; i < count; i++) {
        NSLog(@"%d", i);
    }
    NSLog(@"*******");
}

#pragma mark--造成死锁
- (void)createCrashWithGCD{
    
    dispatch_queue_t queue = dispatch_queue_create("me.tutuge.test.gcd", DISPATCH_QUEUE_SERIAL);
    
    dispatch_apply(3, queue, ^(size_t i) {
        NSLog(@"apply loop: %zu", i);
        
        //再来一个dispatch_apply！死锁！   //在dispatch_apply中不能嵌套dispatch_apply
        dispatch_apply(3, queue, ^(size_t j) {
            NSLog(@"apply loop inside %zu", j);
        });
    });
    
    //在dispatch_get_main_queue同步调用会造成死锁， 应该使用dispatch_async在dispatch_get_main_queue异步调用刷新UI
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSLog(@"1111");
    });
}

@end
