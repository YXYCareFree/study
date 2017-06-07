
//
//  UILabel+VerticalAlignment.h
//  DPL
//
//  Created by sugar on 5/29/14.
//  Copyright (c) 2014 sugar. All rights reserved.
//
// vertical alignment values
#import <UIKit/UIKit.h>

typedef enum UITextVerticalAlignment {
    UITextVerticalAlignmentTop,
    UITextVerticalAlignmentMiddle,
    UITextVerticalAlignmentBottom
} UITextVerticalAlignment;

@interface UILabel(VerticalAlignment)

// getter
-(UITextVerticalAlignment)textVerticalAlignment;

// setter
-(void)setTextVerticalAlignment:(UITextVerticalAlignment)textVerticalAlignment;

@end
/*
@interface UIViewController (presentHook)
- (void)safePresentModalViewController:(UIViewController *)ctr animated:(BOOL)ani;
@end
*/