//
//  ViewController.m
//  FMDB
//
//  Created by beyondSoft on 16/8/15.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "TestTableViewCell.h"
#import "TestModel.h"
#import "CollectionViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"

static NSString * reuseCellID = @"REUSE";
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSMutableArray * dataSource;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.tableView registerNib:[UINib nibWithNibName:@"TestTableViewCell" bundle:nil] forCellReuseIdentifier:reuseCellID];

    self.automaticallyAdjustsScrollViewInsets = NO;
}

- (IBAction)rightBarBtnClicked:(UIBarButtonItem *)sender {

    CollectionViewController * vc = [CollectionViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TestTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCellID forIndexPath:indexPath];
    if (!cell) {
        cell = [[TestTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCellID];
    }

    TestModel * model = _dataSource[indexPath.row];
    [cell configModel:model];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{


    NSLog(@"%f", [tableView fd_heightForCellWithIdentifier:reuseCellID configuration:nil]);
    return  [tableView fd_heightForCellWithIdentifier:reuseCellID configuration:^(id cell) {

        [self config:cell];
    }];
}

- (void)config:(TestTableViewCell *)cell{
    cell.fd_enforceFrameLayout = YES;
}

- (NSMutableArray *)dataSource{

    if (!_dataSource) {

        _dataSource = [NSMutableArray new];

        for (int i = 0; i < 10; i++) {

            TestModel * model = [TestModel new];
            model.name = @"姓名：test";
            model.age = i + 10;
            model.Description = @"descriptionuasdasdhnnkwqhj,nsdakjhjdopwqdjsadmiqwu";
            [_dataSource addObject:model];
        }
    }
    return _dataSource;
}

@end
