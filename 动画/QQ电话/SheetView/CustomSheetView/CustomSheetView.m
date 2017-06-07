//
//  CustomSheetView.m
//  SheetView
//
//  Created by beyondSoft on 16/8/31.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "CustomSheetView.h"
#import "ActionSheetView.h"

@interface CustomSheetView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) ActionSheetView * actionSheetView;

@property (nonatomic, strong) UITableView * tableView;

@end

@implementation CustomSheetView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self addSubview:self.tableView];
        self.frame = _tableView.frame;
        self.actionSheetView = [ActionSheetView sheetWithContainedView:self];
        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)show{
    [self.actionSheetView show];
}

- (void)dismiss{
    [self.actionSheetView dismiss];
}

#pragma mark--UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = @"test";
    return cell;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    return @"                   请选择支付方式";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 40)];
    label.textAlignment = NSTextAlignmentCenter;
    label.text = @"请选择支付方式";
    return label;
}

#pragma mark--UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

#pragma mark-- Getter
-(UITableView *)tableView{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 300)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
