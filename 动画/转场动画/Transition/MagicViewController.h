//
//  MagicViewController.h
//  Transition
//
//  Created by beyondSoft on 16/8/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MagicViewController : UIViewController

@property (nonatomic, copy) void(^dismissConfig)(NSIndexPath * indexPath);

@property (nonatomic, assign) NSInteger index;

@end
