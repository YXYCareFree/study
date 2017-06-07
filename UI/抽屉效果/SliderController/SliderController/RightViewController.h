//
//  RightViewController.h
//  SliderController
//
//  Created by beyondSoft on 16/7/5.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKRevealController.h"
#import "MMDrawerController.h"

@interface RightViewController : UIViewController
@property (nonatomic, strong) PKRevealController * revealVC;
@property (nonatomic, strong) UINavigationController * nav;
@property (nonatomic, strong) MMDrawerController * mmdVC;

@end
