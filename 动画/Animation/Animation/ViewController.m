//
//  ViewController.m
//  Animation
//
//  Created by beyondSoft on 16/3/21.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "UIView+Twinkle.h"
#define STRING_ISNIL(__POINTER) (__POINTER == nil || [__POINTER isEqualToString:@""] || [__POINTER isEqualToString:@"(null)"] || [__POINTER isEqualToString:@"null"]|| [__POINTER isEqualToString:@"(NULL)"] || [__POINTER isEqualToString:@"NULL"] || [__POINTER isEqualToString:@"<null>"] || __POINTER == NULL || [__POINTER isKindOfClass:[NSNull class]] || [[__POINTER stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0)?YES:NO
@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIButton *btn;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * str ;
    if (STRING_ISNIL(str)) {
        NSLog(@"%@***str=nil", str);
    }
}

- (IBAction)btn:(id)sender {
    [sender twinkle];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
