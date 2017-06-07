//
//  ViewController.m
//  UISlider
//
//  Created by beyondSoft on 16/5/16.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UISlider * slider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];

 //   NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
//    if ([[UIApplication sharedApplication] canOpenURL:url]) {
//        [[UIApplication sharedApplication] openURL:url];
//    }

//    _slider = [[UISlider alloc] initWithFrame:CGRectMake(30, 90, 300, 10)];
//
//    [self.view addSubview:_slider];
//    [_slider addTarget:self action:@selector(sliderValueChanged) forControlEvents:UIControlEventValueChanged];
}

- (void)sliderValueChanged{
    NSLog(@"changed");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
