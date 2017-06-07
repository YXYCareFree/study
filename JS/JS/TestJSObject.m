//
//  TestJSObject.m
//  JS
//
//  Created by beyondSoft on 16/5/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "TestJSObject.h"

@implementation TestJSObject

- (void)TestNoParameter{
    NSLog(@"none");
}

- (void)TestOneParameter:(NSString *)message{

    NSLog(@"%@", message);
}

- (void)TestTwoParameters:(NSString *)message1 SecondParameter:(NSString *)message2{

    NSLog(@"two");
}

@end
