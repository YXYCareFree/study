//
//  LogInInterface.h
//  MVC
//
//  Created by beyondSoft on 16/4/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ViewController;

@interface LogInInteractor : NSObject

@property (nonatomic, weak) ViewController * vc;

- (void)logIn;
@end
