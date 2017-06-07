//
//  UIButton+Block.m
//  MVVM
//
//  Created by beyondSoft on 16/4/26.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "UIButton+Block.h"
#import <objc/runtime.h>

static const char __BtnBlock__;

@implementation UIButton (Block)

- (void)handleWithBlock:(BtnBlock)block{

    if (block) {

        objc_setAssociatedObject(self, &__BtnBlock__, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
    [self addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)btnAction{

    BtnBlock blcok = objc_getAssociatedObject(self, &__BtnBlock__);
    blcok();
}

@end
