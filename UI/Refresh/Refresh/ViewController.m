//
//  ViewController.m
//  Refresh
//
//  Created by beyondSoft on 16/6/29.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "LoadViewController.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton * redView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initUI];
}

- (void)initUI{


    _redView = [[UIButton alloc] initWithFrame:CGRectMake(0, 70, 100, 100)];
    [_redView addTarget:self action:@selector(redViewClicked:) forControlEvents:UIControlEventTouchUpInside];
    _redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:_redView];

    [UIView animateKeyframesWithDuration:5 delay:0 options:UIViewAnimationOptionCurveLinear |UIViewAnimationOptionAllowUserInteraction animations:^{

        _redView.layer.transform = CATransform3DMakeTranslation(0, 300, 0);

    } completion:^(BOOL finished) {

    }];



    UIButton * button = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 100, 50)];
    [button setTitle:@"btn" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(btn) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)redViewClicked:(UIButton *)btn{

    NSLog(@"click");
}

- (void)btn{

    LoadViewController * vc = [LoadViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    UITouch * touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self.view];

    if (CGRectContainsPoint(((CALayer *)[_redView.layer presentationLayer]).frame, touchPoint)) {
        [self redViewClicked:_redView];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
