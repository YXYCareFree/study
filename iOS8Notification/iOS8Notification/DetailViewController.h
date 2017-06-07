//
//  DetailViewController.h
//  iOS8Notification
//
//  Created by beyondSoft on 16/9/27.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

