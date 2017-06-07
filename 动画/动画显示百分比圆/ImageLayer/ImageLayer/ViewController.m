//
//  ViewController.m
//  ImageLayer
//
//  Created by beyondSoft on 16/7/11.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(200, 200, 60, 60)];
    label.text = @"test";
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    //设置背景颜色
//    label.clipsToBounds = YES;
//    label.layer.cornerRadius = 30;
//    label.backgroundColor = [UIColor redColor];

    [self.view addSubview:label];

    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = label.bounds;

    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:label.bounds];

    shapeLayer.path = path.CGPath;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.lineWidth = 5.0f;
    shapeLayer.strokeColor = [UIColor redColor].CGColor;

    [label.layer addSublayer:shapeLayer];

    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = 3.0f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:0.5f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    [shapeLayer addAnimation:pathAnima forKey:@"strokeEndAnimation"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
