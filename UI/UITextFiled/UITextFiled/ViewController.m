//
//  ViewController.m
//  UITextFiled
//
//  Created by beyondSoft on 16/5/31.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//
#ifdef DEBUG
# define DLog(fmt, ...) NSLog((@"[文件名:%s]\n" "[函数名:%s]\n" "[行号:%d] \n" fmt), __FILE__, __FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
# define DLog(...);
#endif

#import "ViewController.h"

static const NSString * constStr1 = @"I'm a const NSString * str";

static NSString * const constStr2 = @"I'm a NSString * const str";

static NSString const * constStr3 = @"I'm a NSString const * Str";

@interface ViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textFiled;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    self.textFiled.delegate = self;

    DLog(@"constStr1=%@\nconstStr2=%@\nconstStr3=%@", constStr1, constStr2, constStr3);
    NSLog(@"constStr1=%p\nconstStr2=%p\nconstStr3=%p", &constStr1, &constStr2, &constStr3);

    constStr1 = @"1";

    constStr3 = @"3";
    NSLog(@"constStr1=%@\nconstStr2=%@\nconstStr3=%@", constStr1, constStr2, constStr3);
    NSLog(@"constStr1=%p\nconstStr2=%p\nconstStr3=%p", &constStr1, &constStr2, &constStr3);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{

    [self.textFiled resignFirstResponder];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.textFiled resignFirstResponder];
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
