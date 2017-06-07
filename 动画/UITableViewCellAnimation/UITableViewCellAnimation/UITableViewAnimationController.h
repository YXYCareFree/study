//
//  UITableViewAnimationController.h
//  UITableViewCellAnimation
//
//  Created by beyondSoft on 16/9/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, UITableViewCellAnimationStyle) {
    UITableViewCellAnimationStyleFade,      //透明度的变化
    UITableViewCellAnimationStylePosition,  //位置变化
    UITableViewCellAnimationStyleScale,     //缩放
    UITableViewCellAnimationStyleRotateX,   //X轴旋转
    UITableViewCellAnimationStyleRotateY    //Y轴旋转
};

@interface UITableViewAnimationController : UIViewController


@property (nonatomic, strong) NSArray * dataSource;

@property (nonatomic, assign) UITableViewCellAnimationStyle cellAnimationStyle;

@end
