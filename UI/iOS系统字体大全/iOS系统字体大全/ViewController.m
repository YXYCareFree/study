//
//  ViewController.m
//  font
//
//  Created by softlipa软嘴唇 on 16/7/18.
//  Copyright © 2016年 softlipa软嘴唇. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic,strong) UITableView *tableVie;
@property (nonatomic,strong) NSMutableArray *data;

@end

@implementation ViewController

#pragma mark - 💤 懒加载
- (UITableView *)tableVie {
    
    if (!_tableVie) {
        
        _tableVie = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
        _tableVie.delegate   = self;
        _tableVie.dataSource = self;
        _tableVie.rowHeight  = 80.0f;
        _tableVie.backgroundColor = [UIColor clearColor];
        
        [self.view addSubview:_tableVie];
    }
    
    return _tableVie;
}

- (NSMutableArray *)data {
    
    if (!_data) {
        
        _data = [[NSMutableArray alloc]init];
        
        
        NSArray *familyNames =[UIFont familyNames];
        
        for( NSString*familyName in familyNames ){
            NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
            for( NSString *fontName in fontNames ) {
                [_data addObject:fontName];
            }
        }
    }
    return _data;
}


#pragma mark - ♻️ 生命周期

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"iOS系统字体大全";
    
    [self tableVie];
    [self data];
}


#pragma mark - 创建tableView
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return  _data.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = @"cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:0 reuseIdentifier:ID];
    }
    
    cell.textLabel.text  = _data[indexPath.row];
    cell.textLabel.font  = [UIFont fontWithName:_data[indexPath.row] size:18.0f];
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"当前点击的字体是: %@",_data[indexPath.row]);
}


//允许 Menu菜单
- (BOOL)tableView:(UITableView *)tableView shouldShowMenuForRowAtIndexPath:(NSIndexPath *)indexPath {

    return YES;
}

//每个cell都会点击出现Menu菜单
- (BOOL)tableView:(UITableView *)tableView canPerformAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView performAction:(SEL)action forRowAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
    
    if (action == @selector(copy:)) {
        
        [UIPasteboard generalPasteboard].string = [_data objectAtIndex:indexPath.row];
    }
    
//    if (action == @selector(cut:)) {
//        
//        [UIPasteboard generalPasteboard].string = [_data objectAtIndex:indexPath.row];
//        
//        [_data replaceObjectAtIndex:indexPath.row withObject:@""];
//        
//        [self.tableVie reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//    }
    
//    if (action == @selector(paste:)) {
//        
//        NSString *pasteString = [UIPasteboard generalPasteboard].string;
//        
//        NSString *tempString = [NSString stringWithFormat:@"%@%@",[_data objectAtIndex:indexPath.row],pasteString];
//        
//        [_data replaceObjectAtIndex:indexPath.row withObject:tempString];
//        
//        [self.tableVie reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
//    }
    
}

@end
