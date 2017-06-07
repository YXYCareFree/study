//
//  ViewController.h
//  MVC
//
//  Created by beyondSoft on 16/4/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
@class LogInInteractor;

@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *psWordTextField;

@property (nonatomic, strong) LogInInteractor * interactor;
@end
