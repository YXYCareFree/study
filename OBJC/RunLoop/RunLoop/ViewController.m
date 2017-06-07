//
//  ViewController.m
//  RunLoop
//
//  Created by beyondSoft on 16/6/12.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (nonatomic, strong) dispatch_source_t GCDTimer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self.scrollView setContentSize:CGSizeMake(999, 200)];
    self.scrollView.showsHorizontalScrollIndicator = YES;
    self.scrollView.showsVerticalScrollIndicator = YES;
    self.scrollView.backgroundColor = [UIColor grayColor];
    NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timer1) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];

    self.GCDTimer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, dispatch_get_main_queue());
    dispatch_source_set_timer(self.GCDTimer, DISPATCH_TIME_NOW, 1 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(self.GCDTimer, ^{
        NSLog(@"***%@\n", [NSRunLoop currentRunLoop].currentMode);
    });
    dispatch_resume(self.GCDTimer);
}

- (void)timer1{
    NSLog(@"%@", [NSRunLoop currentRunLoop].currentMode);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
