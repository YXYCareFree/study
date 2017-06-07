//
//  UIViewController+Log.m
//  MVVM
//
//  Created by beyondSoft on 16/4/15.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "UIViewController+Log.h"
#import <objc/runtime.h>

@implementation UIViewController (Log)

+ (void)load{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{


        //获取到这个类的viewDidLoad方法，他的类型是一个object_method结构体的指针
        Method viewDidLoad = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method viewDidLoaded = class_getInstanceMethod(self, @selector(viewDidLoaded));
        method_exchangeImplementations(viewDidLoad, viewDidLoaded);


        //class_getClassMethod获取类方法
//            Method originalMethod = class_getClassMethod(class, originalSelector);
//            Method swizzledMethod = class_getClassMethod(class, swizzledSelector);
//            //交换实现
//            method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

- (void)viewDidLoaded{

    [self viewDidLoaded];
    NSLog(@"viewWillAppera:%@", self);
}

@end
