//
//  ViewController.m
//  iOS10Notification
//
//  Created by beyondSoft on 16/10/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)customUINotifi:(id)sender {

    UNMutableNotificationContent * content = [UNMutableNotificationContent new];
    content.title = @"title";
    content.subtitle = @"subtitle";
    content.body = @"you are a good boy!";
    content.categoryIdentifier = @"threeBtnNotification";
    content.userInfo = @{@"image": @"0"};

    NSURL * imageUrl = [[NSBundle mainBundle] URLForResource:@"0" withExtension:@"png"];
    UNNotificationAttachment * imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:@"" URL:imageUrl options:nil error:nil];
    if (imageAttachment) {
        content.attachments = @[imageAttachment];
    }

    UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];

    UNNotificationRequest * requset = [UNNotificationRequest requestWithIdentifier:@"customUI" content:content trigger:trigger];

    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:requset withCompletionHandler:^(NSError * _Nullable error) {

    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
