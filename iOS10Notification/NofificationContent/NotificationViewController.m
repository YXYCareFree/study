//
//  NotificationViewController.m
//  NofificationContent
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
@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@end

@implementation NotificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any required interface initialization here.
}
//http://www.sinaimg.cn/dy/slidenews/8_img/2016_41/199_211867_638257.jpg
- (void)didReceiveNotification:(UNNotification *)notification {
    self.label.text = notification.request.content.body;
    self.btn1.titleLabel.text = @"btn1";
    self.btn2.titleLabel.text = @"text2";

    self.imageView.image = [UIImage imageWithContentsOfFile:notification.request.content.attachments[0].URL.path];


//    UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.sinaimg.cn/dy/slidenews/8_img/2016_41/199_211867_638257.jpg"]]];
//    //存储图片
//    NSString * path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"image.png"];
//    NSArray *paths =NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
//    NSString *filePath = [[paths objectAtIndex:0]stringByAppendingPathComponent:[NSString stringWithFormat:@"iamge",nil]];  // 保存文件的名称
//
//    //
//    // [UIImagePNGRepresentation(image) writeToFile:path atomically:YES];
//
//    //转为NSData保存该方法转化的NSData大小较小（清晰度要求不高时使用）
//    [UIImageJPEGRepresentation(image, 1.0) writeToFile:path atomically:YES];
//    self.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfFile:filePath]];
}

@end
