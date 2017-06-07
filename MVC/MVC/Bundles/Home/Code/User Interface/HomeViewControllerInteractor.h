//
//  HomeViewControllerInteractor.h
//  MVC
//
//  Created by beyondSoft on 16/4/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class HomeViewController;

@interface HomeViewControllerInteractor : NSObject<UITableViewDataSource, UITableViewDelegate>


@property (nonatomic, weak) HomeViewController * homeVC;
@property (nonatomic, strong) NSArray * dataSource;

@end
