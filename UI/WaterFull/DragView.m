//
//  DragView.m
//  WaterFull
//
//  Created by beyondSoft on 16/7/28.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "DragView.h"

@implementation DragView
{
    CGPoint beganPoint;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch * touch = [touches anyObject];
    beganPoint = [touch locationInView:self];
    [super touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch * touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self];

    CGRect frame = self.frame;
    frame.origin.x += currentPoint.x - beganPoint.x;
    frame.origin.y += currentPoint.y - beganPoint.y;
    if (frame.origin.x > [UIScreen mainScreen].bounds.size.width - CGRectGetWidth(self.frame)) {
        frame.origin.x = [UIScreen mainScreen].bounds.size.width - CGRectGetWidth(self.frame);
    }
    if (frame.origin.x < 0) {
        frame.origin.x = 0;
    }

    if (frame.origin.y > [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(self.frame)) {
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - CGRectGetHeight(self.frame);
    }
    if (frame.origin.y < 0) {
        frame.origin.y = 0;
    }
    self.frame = frame;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

}

@end
