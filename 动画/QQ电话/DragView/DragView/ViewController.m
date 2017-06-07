//
//  ViewController.m
//  DragView
//
//  Created by beyondSoft on 16/8/23.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "PhoneViewController.h"
#import "UIViewController+XWTransition.h"
#import "UINavigationController+XWTransition.h"
#import "XWCircleSpreadAnimator.h"

@interface ViewController ()

@property (nonatomic, strong) UIButton * dragBtn;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initDragBtn];
}

- (void)initDragBtn{

    self.dragBtn = [[UIButton alloc] initWithFrame:CGRectMake(30, 100, 60, 60)];

    [self.dragBtn addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(drag:)]];
    [self.dragBtn addTarget:self action:@selector(dragBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.dragBtn.clipsToBounds = YES;
    self.dragBtn.layer.cornerRadius = 30;
    [self.dragBtn setTitle:@"点我啊" forState:UIControlStateNormal];
    [self.dragBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];

    self.dragBtn.backgroundColor = [UIColor grayColor];

    [self.view addSubview:self.dragBtn];
}

- (void)dragBtnClicked:(UIButton *)btn{

    PhoneViewController * vc = [PhoneViewController new];

    XWCircleSpreadAnimator * animator = [XWCircleSpreadAnimator xw_animatorWithStartCenter:self.dragBtn.center radius:30];
    animator.toDuration = 0.5f;
    animator.backDuration = 0.5f;

    [self xw_presentViewController:vc withAnimator:animator];
}

- (void)drag:(UIPanGestureRecognizer *)panGesture{

    CGPoint transitionP = [panGesture translationInView:panGesture.view];

    CGFloat transitionX = fmax(30, fmin(self.dragBtn.center.x + transitionP.x, self.view.bounds.size.width - 30));
    CGFloat transitionY = fmax(64 + 30, fmin(self.dragBtn.center.y + transitionP.y, CGRectGetHeight(self.view.bounds) - 30));
    self.dragBtn.center = CGPointMake(transitionX, transitionY);

    [panGesture setTranslation:CGPointZero inView:panGesture.view];

    if (panGesture.state == UIGestureRecognizerStateEnded) {

        NSLog(@"dragEnd");
        if (self.dragBtn.center.x >= [UIScreen mainScreen].bounds.size.width / 2) {
            [UIView animateWithDuration:0.3 animations:^{

            self.dragBtn.center = CGPointMake([UIScreen mainScreen].bounds.size.width - self.dragBtn.frame.size.width / 2, self.dragBtn.center.y);
            }];

        }else{
            [UIView animateWithDuration:0.3 animations:^{

            self.dragBtn.center = CGPointMake(self.dragBtn.frame.size.width / 2, self.dragBtn.center.y);
            }];

        }
    }

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
