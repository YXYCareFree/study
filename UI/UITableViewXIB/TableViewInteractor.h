//
//  TableViewInteractor.h
//  UITableViewXIB
//
//  Created by beyondSoft on 16/7/19.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ViewController;

@interface TableViewInteractor : NSObject<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) NSMutableArray * dataSource;

@property (nonatomic, weak) ViewController * controller;

@end
