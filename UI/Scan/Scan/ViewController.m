//
//  ViewController.m
//  Scan
//
//  Created by beyondSoft on 16/7/14.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "ScanViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];

//打开外部应用
    //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"test://second"]];

    [self initScanBtn];
}

- (void)initScanBtn{

    UIView * rightView = [[UIView alloc] initWithFrame:CGRectMake(0, 10, 80, 60)];
    UIButton * scanBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    [scanBtn setImage:[UIImage imageNamed:@"btn_scan_qrcode"] forState:UIControlStateNormal];
    [scanBtn addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    [rightView addSubview:scanBtn];

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(0, 30, 80, 20)];
    label.text = @"扫一扫";
    label.textColor = [UIColor whiteColor];
    label.font = [UIFont boldSystemFontOfSize:8];
    label.textAlignment = NSTextAlignmentCenter;
    [rightView addSubview:label];

    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scan)];
    [rightView addGestureRecognizer:tap];

    UIBarButtonItem * rightBarBtn = [[UIBarButtonItem alloc] initWithCustomView:rightView];
    self.navigationItem.rightBarButtonItem = rightBarBtn;
}

- (void)scan{

    ScanViewController * scanVC = [ScanViewController new];
    [self.navigationController pushViewController:scanVC animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
