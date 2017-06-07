//
//  CustomNotificationCategory.m
//  UserNotification
//
//  Created by beyondSoft on 16/9/29.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "CustomNotificationCategory.h"

static NSString * inputActionID = @"inputActionID";
static NSString * cancelActionID = @"cancelActionID";
static NSString * confirmActionID = @"confirmActionID";

@implementation CustomNotificationCategory

+ (void)registerNotificationCategory{

    //UNNotificationActionOptionAuthenticationRequired 需要解锁
    //UNNotificationActionOptionDestructive  显示为红色
    //UNNotificationActionOptionForeground   点击打开app
    UNTextInputNotificationAction * inputAction = [UNTextInputNotificationAction actionWithIdentifier:inputActionID title:@"回复" options:UNNotificationActionOptionAuthenticationRequired];

    UNNotificationAction * confirmAction = [UNNotificationAction actionWithIdentifier:confirmActionID title:@"确认" options:UNNotificationActionOptionDestructive];
   // UNNotificationAction * cancelAction = [UNNotificationAction actionWithIdentifier:cancelActionID title:@"取消" options:UNNotificationActionOptionNone];

    //UNNotificationCategoryOptionNone
    //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
    //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
    UNNotificationCategory * twoBtnCategory = [UNNotificationCategory categoryWithIdentifier:@"twoBtnNotification" actions:@[inputAction, confirmAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];

    /**
     *  每一个category都需要单独创建相应的action
     */
    UNTextInputNotificationAction * inputAction2 = [UNTextInputNotificationAction actionWithIdentifier:@"input" title:@"回复" options:UNNotificationActionOptionAuthenticationRequired];

    UNNotificationAction * confirmAction2 = [UNNotificationAction actionWithIdentifier:@"confirm" title:@"确认" options:UNNotificationActionOptionDestructive];
    UNNotificationAction * cancelAction = [UNNotificationAction actionWithIdentifier:cancelActionID title:@"取消" options:UNNotificationActionOptionNone];

    //UNNotificationCategoryOptionNone
    //UNNotificationCategoryOptionCustomDismissAction  清除通知被触发会走通知的代理方法
    //UNNotificationCategoryOptionAllowInCarPlay       适用于行车模式
    
    /**
     *该categoryWithIdentifier必须和NotificationContent文件的Info.plist文件里的UNNotificationExtensionCategory字段名字一致（即自我定制的通知UI）
     */
    UNNotificationCategory * threeBtnCategory = [UNNotificationCategory categoryWithIdentifier:@"threeBtnNotification" actions:@[inputAction2, confirmAction2, cancelAction] intentIdentifiers:@[] options:UNNotificationCategoryOptionCustomDismissAction];

    NSSet * set = [[NSSet alloc] initWithObjects:twoBtnCategory, threeBtnCategory, nil];
    [[UNUserNotificationCenter currentNotificationCenter] setNotificationCategories:set];
}

@end
