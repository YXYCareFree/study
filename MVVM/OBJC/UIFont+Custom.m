//
//  UIFont+Custom.m
//  MVVM
//
//  Created by beyondSoft on 16/4/8.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "UIFont+Custom.h"
#import <objc/runtime.h>
@implementation UIFont (Custom)

+ (void)load {

    Method originalMethod = class_getClassMethod(self, @selector(systemFontOfSize:));
    Method swizzledMethod = class_getClassMethod(self, @selector(custom_systemFontOfSize:));
    //交换实现
    method_exchangeImplementations(originalMethod, swizzledMethod);
    NSLog(@"#####");
}

+ (UIFont *)custom_systemFontOfSize:(CGFloat)fontSize {
    NSLog(@"%f", fontSize);
    return [self custom_systemFontOfSize:fontSize * 320.0 / [UIScreen mainScreen].bounds.size.width];
}

@end
