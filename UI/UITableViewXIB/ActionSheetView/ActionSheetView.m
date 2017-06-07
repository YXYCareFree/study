//
//  ActionSheetView.m
//  UITableViewXIB
//
//  Created by beyondSoft on 16/8/30.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ActionSheetView.h"

@interface ActionSheetView ()

@property (nonatomic, strong) UILabel * label1;

@property (nonatomic, strong) UILabel * label2;

@end

@implementation ActionSheetView


- (instancetype)init{
    self = [super init];
    if (self) {
        
        self.backgroundColor = [UIColor clearColor];
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300);

        self.label1 = [[UILabel alloc] initWithFrame:CGRectMake(80, 90, 100, 50)];
        [self.label1 setText:@"test1"];
        self.label1.textColor = [UIColor redColor];
        self.label1.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label1];

        self.label2 = [[UILabel alloc] initWithFrame:CGRectMake(80, 141, 100, 50)];
        [self.label2 setText:@"test2"];
        [self.label2 setTextColor:[UIColor redColor]];
        self.label2.textAlignment = NSTextAlignmentCenter;
        [self addSubview:self.label2];
    }
    return self;
}

- (void)show:(UIView *)superView{

    [superView addSubview:self];
//    superView.alpha = 0.5;
//    self.alpha = 1.0;
    [UIView animateWithDuration:0.5 animations:^{

        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 300);

    }];

}

- (void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    // 不允许禁用user interaction，保持弹出视图占用
    [super setUserInteractionEnabled:YES];
}

- (void)show{

    [[UIApplication sharedApplication].keyWindow addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{

        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - 300, [UIScreen mainScreen].bounds.size.width, 300);
    }];
    
}

- (void)dismiss:(UIView *)superView{
    
    [UIView animateWithDuration:0.5 animations:^{
        self.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, 300);
        [self removeFromSuperview];
    }];
}

@end
