//
//  TableViewInteractor.m
//  UITableViewXIB
//
//  Created by beyondSoft on 16/7/19.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "TableViewInteractor.h"
#import "ViewController.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "TableViewCell.h"

static NSString * str;

@implementation TableViewInteractor

- (NSMutableArray *)dataSource{

    if (!_dataSource) {
        NSArray * arr = @[@"111", @"222", @"333", @"4444"];
        _dataSource = [NSMutableArray arrayWithArray:arr];
    }
    return _dataSource;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

//    static NSString * cellID = @"cellID";
//    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//
//    if (!cell) {
//        switch (indexPath.row) {
//            case 0:
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//                break;
//            case 1:
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellID];
//                break;
//            case 2:
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:cellID];
//                break;
//            case 3:
//                cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellID];
//
//                break;
//            default: cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//                break;
//        }
//    }
//
//    cell.textLabel.text = self.dataSource[indexPath.row];
//
//    cell.selectionStyle = UITableViewCellSelectionStyleBlue;
//    cell.detailTextLabel.text = @"detail";


    //定制的Cell
    TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];

//    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (void)configureCell:(TableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath{

    NSInteger i = arc4random_uniform(30);
    str = @"1";
    for (int j = 0; j < i; j++) {

        str = [NSString stringWithFormat:@"%@test%lu", str, i];
    }
    cell.titleLabel.text = str;
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

   return [tableView fd_heightForCellWithIdentifier:@"CELL" configuration:^(id cell) {
       [self configureCell:cell atIndexPath:indexPath];
   }] + 1;
}

//返回每个cell的编辑属性
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {

        return UITableViewCellEditingStyleInsert;
    }
    return UITableViewCellEditingStyleDelete;
}
//此方法用于实现手势滑动出现删除按钮
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{

    if (editingStyle == UITableViewCellEditingStyleDelete) {

        [self.dataSource removeObjectAtIndex:indexPath.row];
        [self.controller.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
        [self.controller.tableView reloadData];
    }
    if ( editingStyle == UITableViewCellEditingStyleInsert) {

        [self.dataSource insertObject:@"test" atIndex:indexPath.row];
        [self.controller.tableView reloadData];
    }

}
//返回的删除按钮的title
- (nullable NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"删除";
}

@end
