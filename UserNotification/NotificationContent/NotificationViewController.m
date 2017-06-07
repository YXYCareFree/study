//
//  NotificationViewController.m
//  NotificationContent
//
//  Created by beyondSoft on 16/10/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "NotificationViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <UserNotificationsUI/UserNotificationsUI.h>

@interface NotificationViewController () <UNNotificationContentExtension>

@property IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}

- (void)didReceiveNotification:(UNNotification *)notification {
  //  NSDictionary * dic = notification.request.content.userInfo;

//    self.label.text = dic[@"title"];
    UNNotificationContent * content = notification.request.content;
//    content.body = @"";
//    content.title = @"";
//    content.subtitle = @"";
    
    self.label.text = @"test";
    self.imageView.image = [UIImage imageNamed:content.launchImageName];
}

/**
 *  实现此代理方法就不会走收到消息推送的处理方法
 *
 */
- (void)didReceiveNotificationResponse:(UNNotificationResponse *)response completionHandler:(void (^)(UNNotificationContentExtensionResponseOption option))completion{

    if (response.actionIdentifier) {
        UIImage * image = [UIImage imageNamed:@"0"];
        NSLog(@"*******%@", image);
        completion(UNNotificationContentExtensionResponseOptionDismiss);
    }

}

@end
