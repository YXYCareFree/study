//
//  UIView+TagString.m
//  MVVM
//
//  Created by beyondSoft on 16/4/25.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "UIView+TagString.h"
#import <objc/runtime.h>

#define TagWithString "tagString"

@implementation UIView (TagString)

@dynamic tagString;

-(void)setTagString:(NSString *)value{

    objc_setAssociatedObject(self, TagWithString, value, OBJC_ASSOCIATION_RETAIN);
}

- (NSString *)tagString{

    NSObject * objc = objc_getAssociatedObject(self, TagWithString);
    if (objc && [objc isKindOfClass:[NSString class]]) {
        return (NSString *)objc;
    }
    return nil;
}

- (UIView *)viewWithTagString:(NSString *)tagString{

    if (tagString == nil) {
        return nil;
    }
    for (UIView * subView in self.subviews) {
        NSString * tag = subView.tagString;
        if ([tag isEqualToString:tagString]) {
            return subView;
        }
    }
    return nil;
}

@end
