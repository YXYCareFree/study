//
//  UIImage+Additional.h
//  H5Service
//
//  Created by chenwenhong on 14-9-25.
//  Copyright (c) 2014年 Alipay. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additional)

- (UIImage *)fixOrientation;

//使用图层过量会有卡顿现象, 特别是弄圆角或者阴影会很卡, 如果设置图片圆角我们一般用绘图来做
- (UIImage *)cutCircleImage;

@end
