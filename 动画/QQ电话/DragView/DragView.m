//
//  DragView.m
//  DragView
//
//  Created by beyondSoft on 16/8/23.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "DragView.h"

@implementation DragView

//不断的触摸当前View就会调用
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    //获取UITouch
    UITouch * touch = [touches anyObject];
//获取当前点
    CGPoint curP = [touch locationInView:self];
    //获取上一个点
    CGPoint preP = [touch previousLocationInView:self];

    //获取x,y轴的偏移量
    CGFloat offsetX = curP.x - preP.x;
    CGFloat offsetY = curP.y - preP.y;
    //移动View
    self.transform = CGAffineTransformTranslate(self.transform, offsetX, offsetY);
}
//触摸事件被迫打断（电话进来）
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}
//手抬起的时候调用
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    NSLog(@"end");
    //获取UITouch
    UITouch * touch = [touches anyObject];
    //获取当前点
    CGPoint curP = [touch locationInView:self];

    if (curP.x >= [UIScreen mainScreen].bounds.size.width / 2) {
        curP.x = [UIScreen mainScreen].bounds.size.width - self.frame.size.width / 2;
    }else{
        curP.x = self.frame.size.width / 2;
    }
    self.center = curP;
    NSLog(@"%@%@", NSStringFromCGPoint(self.center), NSStringFromCGPoint(curP));
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
