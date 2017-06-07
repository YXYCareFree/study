//
//  HomeViewControllerInteractor.m
//  MVC
//
//  Created by beyondSoft on 16/4/22.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "HomeViewControllerInteractor.h"
#import "HomeViewController.h"

@implementation HomeViewControllerInteractor

-(instancetype)init{

    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeDataSource:) name:@"change" object:nil];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = self.dataSource[indexPath.row];
    return cell;
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)changeDataSource:(NSNotification *)noti{

    _dataSource = @[@"111", @"222", @"333"];
    [_homeVC.tableView reloadData];
}

@end
