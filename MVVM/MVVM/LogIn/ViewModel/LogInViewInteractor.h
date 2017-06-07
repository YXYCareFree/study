//
//  LogInViewInteractor.h
//  MVVM
//
//  Created by beyondSoft on 16/4/8.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LogInViewController;

@interface LogInViewInteractor : NSObject

@property (nonatomic, strong) LogInViewController * logInVC;

- (void)logIn;

@end
