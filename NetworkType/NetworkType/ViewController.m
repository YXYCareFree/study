//
//  ViewController.m
//  NetworkType
//
//  Created by beyondSoft on 16/10/18.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.


}
- (IBAction)btn:(id)sender {

    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"网络状态" message:[self networkingStatesFromStatebar] delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

- (NSString *)networkingStatesFromStatebar {
    // 状态栏是由当前app控制的，首先获取当前app
    UIApplication *app = [UIApplication sharedApplication];

    NSArray *children = [[[app valueForKeyPath:@"statusBar"] valueForKeyPath:@"foregroundView"] subviews];

    int type = 0;
    for (id child in children) {
        if ([child isKindOfClass:[NSClassFromString(@"UIStatusBarDataNetworkItemView") class]]) {
            type = [[child valueForKeyPath:@"dataNetworkType"] intValue];
        }
    }

    NSString *stateString = @"wifi";

    switch (type) {
        case 0:
            stateString = @"notReachable";
            break;

        case 1:
            stateString = @"2G";
            break;

        case 2:
            stateString = @"3G";
            break;

        case 3:
            stateString = @"4G";
            break;

        case 4:
            stateString = @"LTE";
            break;

        case 5:
            stateString = @"wifi";
            break;

        default:
            break;
    }

    return stateString;
}

@end
