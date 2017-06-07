//
//  SearchViewController.m
//  UISearchController
//
//  Created by beyondSoft on 16/9/23.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) UISearchBar * searchBar;
@end

@implementation SearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initSearchBar];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}
#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * cellID = @"cellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];

    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }

    cell.textLabel.text = @"test";
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    _searchBar = [[UISearchBar alloc] initWithFrame:_tableView.tableHeaderView.frame];
//    _searchBar.barTintColor = [UIColor orangeColor];
//    return _searchBar;
//}

#pragma mark--UITableViewDelegate
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 80;
//}
- (void)initSearchBar{

    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 50)];
    _searchBar.delegate = self;

    _searchBar.barTintColor = [UIColor orangeColor];
    _searchBar.tintColor = [UIColor redColor];

    _searchBar.text = @"search";
    _searchBar.placeholder = @"test";

    _searchBar.showsCancelButton = YES;
//    _searchBar.showsSearchResultsButton = YES;
//    _searchBar.showsBookmarkButton = YES;
    self.tableView.tableHeaderView = _searchBar;

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideKeyboard)];
    [self.view addGestureRecognizer:tap];
}
#pragma mark--UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{

    NSLog(@"%@", searchBar.text);
}
- (void)hideKeyboard{
    [self.searchBar resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
