//
//  UIView+TagString.h
//  MVVM
//
//  Created by beyondSoft on 16/4/25.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TagString)

@property (nonatomic, strong) NSString * tagString;

- (UIView *)viewWithTagString:(NSString *)tagString;

@end
