//
//  ViewController.m
//  UITextView
//
//  Created by beyondSoft on 16/5/14.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];



}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{

    NSLog(@"%s", __FUNCTION__);
    if ([text isEqualToString:@"\n"]) {

        if (textView.text.length == 0) {
            textView.text = @"默认输入内容";
        }

        [textView resignFirstResponder];
    }
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{

     NSLog(@"%s", __FUNCTION__);
    if ([textView.text isEqualToString:@"默认输入内容"]) {
        textView.text = @"";
    }
    return YES;
}

- (void)textViewDidEndEditing:(UITextView *)textView{

     NSLog(@"%s", __FUNCTION__);
    NSString * text = textView.text;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
