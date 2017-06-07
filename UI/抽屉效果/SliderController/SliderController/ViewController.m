//
//  ViewController.m
//  SliderController
//
//  Created by beyondSoft on 16/7/5.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "MMDrawerBarButtonItem.h"
#import "LeftViewController.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView * tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self initTableView];
    [self initBarBtn];
}

- (void)initBarBtn{

//    UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc] initWithImage:nil style:UIBarButtonItemStylePlain target:self action:@selector(leftBarBtn:)];

    UIBarButtonItem * leftBarBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(leftBarBtn:)];
    leftBarBtn.title = @"test";
    self.navigationItem.leftBarButtonItem = leftBarBtn;

}

- (void)leftBarBtn:(UIBarButtonItem *)item{

    [self.mm_drawerController toggleDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (void)initTableView{

    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseCell"];
    [self.view addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    static NSString * reuseCell = @"reuseCell";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:reuseCell forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseCell];
    }
    cell.textLabel.text = @"test";
    return cell;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
