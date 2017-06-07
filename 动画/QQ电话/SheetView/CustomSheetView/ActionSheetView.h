//
//  ActionSheetView.h
//  SheetView
//
//  Created by beyondSoft on 16/8/31.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActionSheetView : UIView

+ (ActionSheetView *)sheetWithContainedView:(UIView *)view;

- (void)show;

- (void)dismiss;

@end
