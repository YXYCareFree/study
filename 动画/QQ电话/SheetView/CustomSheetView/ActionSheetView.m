//
//  ActionSheetView.m
//  SheetView
//
//  Created by beyondSoft on 16/8/31.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ActionSheetView.h"

#define ScreenHeight    [UIScreen mainScreen].bounds.size.height
#define ScreenWidth     [UIScreen mainScreen].bounds.size.width

@interface ActionSheetView ()

@property (nonatomic, strong) UIView * bgView;

@property (nonatomic, strong) UIView * maskView;

@property (nonatomic, strong) UIWindow * window;

@property (nonatomic, strong) UIView * containedView;
@end

@implementation ActionSheetView

+ (ActionSheetView *)sheetWithContainedView:(UIView *)view{

    ActionSheetView * sheetView = [[ActionSheetView alloc] initWithFrame:view.frame];
    sheetView.containedView = view;

    [sheetView setupFrame];
    [sheetView setupWindow];
    [sheetView setupBgView];

    return sheetView;
}

- (void)setupFrame{
    self.frame = CGRectMake(0, ScreenHeight, self.frame.size.width, self.frame.size.height);
    [self addSubview:self.containedView];
}

- (void)setupWindow{
    _window = [UIApplication sharedApplication].keyWindow;
}

- (void)setupBgView{

    _bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _bgView.alpha = 0.0;
    _bgView.backgroundColor = [UIColor blackColor];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapBgView)];
    [_bgView addGestureRecognizer:tap];

    [_window addSubview:_bgView];
    [_window addSubview:self];
}

- (void)tapBgView{
    [self dismiss];
}

- (void)show{

    [UIView animateWithDuration:0.5 animations:^{

        self.frame = CGRectMake(0, ScreenHeight - self.frame.size.height, ScreenWidth, self.frame.size.height);
        _bgView.alpha = 0.5f;
    }];
}

- (void)dismiss{

    [UIView animateWithDuration:0.5 animations:^{

        self.frame = CGRectMake(0, ScreenHeight, ScreenWidth, self.frame.size.height);
        _bgView.alpha = 0.0f;
    }];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
