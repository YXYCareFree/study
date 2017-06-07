//
//  UIButton+Block.h
//  MVVM
//
//  Created by beyondSoft on 16/4/26.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^BtnBlock)();

@interface UIButton (Block)

- (void)handleWithBlock:(BtnBlock)block;

@end
