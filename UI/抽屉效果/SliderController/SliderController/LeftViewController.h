//
//  LeftViewController.h
//  SliderController
//
//  Created by beyondSoft on 16/7/5.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PKRevealController.h"
#import "MMDrawerController.h"

@interface LeftViewController : UIViewController
@property (nonatomic, strong) PKRevealController * revealVC;
@property (nonatomic, strong) MMDrawerController * mmdVC;
@end
