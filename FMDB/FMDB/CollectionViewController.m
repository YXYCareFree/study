//
//  CollectionViewController.m
//  FMDB
//
//  Created by beyondSoft on 16/8/15.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "CollectionViewController.h"
#import "TestTableViewCell.h"
#import "TestModel.h"
#import "UITableView+FDTemplateLayoutCell.h"

@interface CollectionViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation CollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    [self.tableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:@"cell"];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   return  [TestModel findAll].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * reuse = @"cell";

    TestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuse forIndexPath:indexPath];
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuse];
    }

    [cell configModel:[TestModel findAll][indexPath.row]];
    cell.collectBtn.hidden = YES;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [tableView fd_heightForCellWithIdentifier:@"cell" configuration:^(id cell){
        [self config:cell];
    }];
}

- (void)config:(TestTableViewCell *)cell{
    cell.fd_enforceFrameLayout = YES;
}


@end
