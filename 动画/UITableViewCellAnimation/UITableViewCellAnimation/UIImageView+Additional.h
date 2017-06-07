//
//  UIImageView+Additional.h
//  UIImageView
//
//  Created by 杨肖宇 on 2017/6/5.
//  Copyright © 2017年 杨肖宇. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Additional)
//设置圆角，可以减少掉帧（在大量设置圆角的时候使用此方法）
- (void)setCorner:(CGFloat)corner;

@end
