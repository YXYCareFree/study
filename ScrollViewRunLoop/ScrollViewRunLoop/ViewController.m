//
//  ViewController.m
//  ScrollViewRunLoop
//
//  Created by beyondSoft on 16/6/21.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "SDCycleScrollView.h"

@interface ViewController ()<SDCycleScrollViewDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSArray *imagesURLStrings = @[
                                  @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                  @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                  @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                  ];
    CGRect frame = CGRectMake(0, 100, self.view.frame.size.width, 200);
    SDCycleScrollView * scrollView = [SDCycleScrollView cycleScrollViewWithFrame:frame delegate:self placeholderImage:nil];
    scrollView.imageURLStringsGroup = imagesURLStrings;
    scrollView.currentPageDotColor = [UIColor redColor];
    scrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    NSArray * titleArr = @[@"第一张", @"第二张", @"第三张"];
    scrollView.titlesGroup = titleArr;

    [self.view addSubview:scrollView];
}

/** 点击图片回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    NSLog(@"****%ld", index);
}

/** 图片滚动回调 */
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didScrollToIndex:(NSInteger)index{
NSLog(@"##########%ld", index);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
