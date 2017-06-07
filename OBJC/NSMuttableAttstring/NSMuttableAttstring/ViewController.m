//
//  ViewController.m
//  NSMuttableAttstring
//
//  Created by beyondSoft on 16/6/15.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "NIAttributedLabel.h"

@interface ViewController ()<NIAttributedLabelDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    [self initNIAttribute];

}

- (void)initNIAttribute{

    NIAttributedLabel * label = [NIAttributedLabel new];
    label.text = @"我是来测试富文本的";
    label.font = [UIFont systemFontOfSize:20];
    [label setFont:[UIFont boldSystemFontOfSize:24] range:NSMakeRange(0, 2)];
    [label setTextColor:[UIColor grayColor] range:NSMakeRange(2, 2)];
    [label addLink:[NSURL URLWithString:@"https://www.baidu.com"] range:NSMakeRange(4, 2)];
    label.frame = (CGRect){CGPointMake(20, 80), CGSizeZero};

    label.delegate = self;
    [label insertImage:[UIImage imageNamed:@"2.png"] atIndex:2 margins:UIEdgeInsetsZero verticalTextAlignment:NIVerticalTextAlignmentMiddle];

    [label sizeToFit];//此方法必须在设置完富文本后再调用，否则展示不出来
    [self.view addSubview:label];

}

- (void)initAttribute{

    NSMutableAttributedString * mutableStr = [[NSMutableAttributedString alloc] initWithString:@"测试一下"];
    [mutableStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(2, 2)];
    [mutableStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(2, 2)];
    [mutableStr addAttribute:NSUnderlineStyleAttributeName value:@1 range:NSMakeRange(2, 2)];
    [mutableStr addAttribute:NSBackgroundColorAttributeName value:@0 range:NSMakeRange(2, 2)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(20, 90, 300, 50)];
    label.attributedText = mutableStr;

    [self.view addSubview:label];

}

#pragma mark NIAttributeLabelDelegate
- (void)attributedLabel:(NIAttributedLabel *)attributedLabel didSelectTextCheckingResult:(NSTextCheckingResult *)result atPoint:(CGPoint)point{
    if (result.resultType == NSTextCheckingTypeLink) {
        [[UIApplication sharedApplication] openURL:result.URL];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
