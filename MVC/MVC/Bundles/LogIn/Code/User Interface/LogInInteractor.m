//
//  LogInInterface.m
//  MVC
//
//  Created by beyondSoft on 16/4/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "LogInInteractor.h"
#import "ViewController.h"
#import "HomeViewController.h"

@implementation LogInInteractor

- (void)logIn{
   
    NSLog(@"登陆了");
    HomeViewController * vc = [HomeViewController new];
    [_vc.navigationController pushViewController:vc animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
      [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil];
    });

}
@end
