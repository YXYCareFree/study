//
//  UIImageView+Additional.m
//  UIImageView
//
//  Created by 杨肖宇 on 2017/6/5.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import "UIImageView+Additional.h"

@implementation UIImageView (Additional)

- (void)setCorner:(CGFloat)corner{
    
    UIBezierPath * path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:UIRectCornerAllCorners cornerRadii:CGSizeMake(corner, corner)];
    
    CAShapeLayer * layer = [CAShapeLayer new];
    layer.frame = self.bounds;
    layer.path = path.CGPath;
    self.layer.mask = layer;
}
@end
