//
//  ViewController.m
//  UserNotification
//
//  Created by beyondSoft on 16/9/26.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import <UserNotifications/UserNotifications.h>

@interface ViewController ()<UNUserNotificationCenterDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //_imageView.image = [UIImage imageNamed:@"0"];
}

- (IBAction)notifi:(id)sender {
   [self createLocalNotification];
}

- (IBAction)actionNotifi:(id)sender {
    [self createLocalActionNotification];
}

- (IBAction)clearNofiti:(id)sender {
    [self clearNotification];

}
- (IBAction)customUINotification:(id)sender {
    [self createCustomUINotification];
}

- (void)createLocalActionNotification{

    UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc] init];
    content.title = @"actionNotifi";
    content.subtitle = @"hah";
    content.body = @"Are you kidding me!";
    content.categoryIdentifier = @"threeBtnNotification";
    //content.categoryIdentifier = @"threeBtnNotification";

    UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"thrBtnNotification" content:content trigger:trigger];

    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

        if (error) {
            NSLog(@"%@", error);
        }else{
            NSLog(@"success");
        }
    }];
}

- (void)createLocalNotification{

    [[UNUserNotificationCenter currentNotificationCenter] getNotificationSettingsWithCompletionHandler:^(UNNotificationSettings * _Nonnull settings) {

        NSLog(@"%lu", settings.authorizationStatus);
    }];

    UNMutableNotificationContent * content = [[UNMutableNotificationContent alloc] init];
    content.title = @"title";
    content.subtitle = @"subtitle";
    content.body = @"body";
    content.badge = @3;


    UNTimeIntervalNotificationTrigger * timerTrigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:2 repeats:NO];

    NSString * requestIdentifier = @"Identifier";
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:content trigger:timerTrigger];

    UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
    [center addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

        NSLog(@"%@", error ? error : @"success");
    }];

    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        UNMutableNotificationContent * newContent = [UNMutableNotificationContent new];
        newContent.subtitle = @"222";
        newContent.title = @"111";
        newContent.body = @"3333";
        newContent.badge = @5;
       // newContent.launchImageName = @"0";
        //newContent.sound = [UNNotificationSound defaultSound];

        NSURL * imageUrl = [[NSBundle mainBundle] URLForResource:@"0" withExtension:@"jpg"];
        UNNotificationAttachment * imageAttachment = [UNNotificationAttachment attachmentWithIdentifier:requestIdentifier URL:imageUrl options:nil error:nil];
        //这里要注意音乐的文件不要太大
        NSURL * mp3Url = [[NSBundle mainBundle] URLForResource:@"2" withExtension:@"mp3"];
        UNNotificationAttachment * mp3Attachment = [UNNotificationAttachment attachmentWithIdentifier:requestIdentifier URL:mp3Url options:nil error:nil];
        //这里经测试只能传一个要么是音乐，要么是图片，音乐只会在下拉通知后才会展示
        //newContent.attachments = @[imageAttachment];
        newContent.attachments = @[mp3Attachment];

        UNNotificationRequest * newRequest = [UNNotificationRequest requestWithIdentifier:requestIdentifier content:newContent trigger:timerTrigger];

        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:newRequest withCompletionHandler:^(NSError * _Nullable error) {
            NSLog(@"%@", error ? error : @"替换消息成功");
        }];
    });

}

- (void)createCustomUINotification{

    UNMutableNotificationContent * content = [UNMutableNotificationContent new];
    content.title = @"customUINotification";
    content.subtitle = @"haha";
    content.body = @"Are you kidding me!";
    content.categoryIdentifier = @"threeBtnNotification";
    content.userInfo = @{@"title": @"you are a good boy!", @"image": @"0"};
    content.launchImageName = @"0.png";

    UNTimeIntervalNotificationTrigger * trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:1 repeats:NO];
    UNNotificationRequest * request = [UNNotificationRequest requestWithIdentifier:@"thrBtnNotification" content:content trigger:trigger];

    [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request withCompletionHandler:^(NSError * _Nullable error) {

        if (error) {
            NSLog(@"%@", error);
        }else{
            NSLog(@"success");
        }
    }];
}

- (void)clearNotification{

    //获取未触发的通知
    [[UNUserNotificationCenter currentNotificationCenter] getPendingNotificationRequestsWithCompletionHandler:^(NSArray<UNNotificationRequest *> * _Nonnull requests) {
        NSLog(@"pending: %@", requests);
    }];

    //获取通知中心列表的通知
    [[UNUserNotificationCenter currentNotificationCenter] getDeliveredNotificationsWithCompletionHandler:^(NSArray<UNNotification *> * _Nonnull notifications) {
        NSLog(@"Delivered: %@", notifications);
    }];

    //清除某一个未触发的通知
    [[UNUserNotificationCenter currentNotificationCenter] removePendingNotificationRequestsWithIdentifiers:@[@"TestRequest1"]];
    //清除某一个通知中心的通知
    [[UNUserNotificationCenter currentNotificationCenter] removeDeliveredNotificationsWithIdentifiers:@[@"TestRequest2"]];
    //对应的删除所有通知
    [[UNUserNotificationCenter currentNotificationCenter] removeAllPendingNotificationRequests];
    [[UNUserNotificationCenter currentNotificationCenter] removeAllDeliveredNotifications];
}

@end
