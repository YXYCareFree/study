//
//  ViewController.m
//  UITableViewXIB
//
//  Created by beyondSoft on 16/4/7.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "TableViewCell.h"
#import "TableViewInteractor.h"
#import "ActionSheetView.h"

static  NSString  * const cellIDE = @"CELL";

@interface ViewController ()

@property (nonatomic, strong) TableViewInteractor * interactor;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initUI];


//    UIView * view = [[UIView alloc] initWithFrame:self.view.bounds];
//    view.alpha = 0.5;
//    view.backgroundColor = [UIColor grayColor];
//    [self.view addSubview:view];
//    ActionSheetView * sheetView = [ActionSheetView new];
//    [sheetView show:self.view];
   // [sheetView show];
}

- (void)initUI{

    [self.tableView registerNib:[UINib nibWithNibName:@"TableViewCell" bundle:nil] forCellReuseIdentifier:cellIDE];

    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"111", @"key1", @"222", @"key2", nil];
    NSData * data = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:nil];
    NSString * jsonStr = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@", jsonStr);

    UIButton * buton = [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 80, 50)];
    [buton setTitle:@"编辑" forState:UIControlStateNormal];
    [buton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [buton addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:buton];

    self.tableView.allowsSelectionDuringEditing = YES;

    //[self.tableView setEditing:YES animated:YES];

    _interactor = [TableViewInteractor new];
    _tableView.delegate = _interactor;
    _tableView.dataSource = _interactor;
    _interactor.controller = self;
}

- (void)btn:(UIButton *)button{

    if ([button.titleLabel.text isEqualToString:@"编辑"]) {

        [button setTitle:@"完成" forState:UIControlStateNormal];
        [self.tableView setEditing:YES animated:YES];

    }else if ([button.titleLabel.text isEqualToString:@"完成"]){

        [button setTitle:@"编辑" forState:UIControlStateNormal];
        [self.tableView setEditing:NO animated:YES];
    }
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
