//
//  NotificationService.m
//  NotificationServiceExtension
//
//  Created by beyondSoft on 16/10/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "NotificationService.h"

@interface NotificationService ()

@property (nonatomic, strong) void (^contentHandler)(UNNotificationContent *contentToDeliver);
@property (nonatomic, strong) UNMutableNotificationContent *bestAttemptContent;

@end

@implementation NotificationService
//触发条件： 1.必须是远程推送且展示样式为alert 2.The remote notification's aps dictionary includes the mutable-content key with the value set to 1
// 有30s的时间去处理远程通知，用于下载图片、音乐、视频，若在时间内没能完成操作会调用serviceExtensionTimeWillExpire
- (void)didReceiveNotificationRequest:(UNNotificationRequest *)request withContentHandler:(void (^)(UNNotificationContent * _Nonnull))contentHandler {
    self.contentHandler = contentHandler;
    self.bestAttemptContent = [request.content mutableCopy];
    
    // Modify the notification content here...
    self.bestAttemptContent.title = [NSString stringWithFormat:@"%@ [modified]", self.bestAttemptContent.title];
    
    self.contentHandler(self.bestAttemptContent);
}

- (void)serviceExtensionTimeWillExpire {
    // Called just before the extension will be terminated by the system.
    // Use this as an opportunity to deliver your "best attempt" at modified content, otherwise the original push payload will be used.
    self.contentHandler(self.bestAttemptContent);
}

@end
