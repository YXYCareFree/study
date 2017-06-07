//
//  ViewController.h
//  UITextFiled
//
//  Created by beyondSoft on 16/5/31.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, TestEnum) {

    Test_Env = 0,
    Online_Env
};

typedef enum : NSUInteger {

    Online__Env
}EnumTest;

@interface ViewController : UIViewController

@property (nonatomic, assign) NSInteger enumTest;

@end

