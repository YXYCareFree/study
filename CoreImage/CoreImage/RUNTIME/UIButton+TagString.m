//
//  UIButton+TagString.m
//  CoreImage
//
//  Created by beyondSoft on 16/5/3.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "UIButton+TagString.h"
#import <objc/runtime.h>

const char __tagString__;

@implementation UIButton (TagString)

- (void)setTagString:(NSString *)tagString{

    objc_setAssociatedObject(self, &__tagString__, tagString, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)tagString{

    NSObject * objc = objc_getAssociatedObject(self, &__tagString__);
    if (objc && [objc isKindOfClass:[NSString class]]) {
        return (NSString *)objc;
    }
    return nil;
}

@end
