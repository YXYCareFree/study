//
//  AppDelegate.m
//  iOS10Notification
//
//  Created by beyondSoft on 16/10/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "CustomNotificationCategory.h"
#import <UserNotifications/UserNotifications.h>
@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self registerNotifi];
    [CustomNotificationCategory registerNotificationCategory];

    return YES;
}

- (void)registerNotifi{

    float sysVersion = [UIDevice currentDevice].systemVersion.floatValue;
    if (sysVersion >= 10.0) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:UNAuthorizationOptionAlert | UNAuthorizationOptionBadge | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if (granted) {
                NSLog(@"消息推送授权成功");
            }else{
                NSLog(@"消息推送授权失败==%@", error);
            }
        }];
    }else{
        //iOS8，9
        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {
            [[UIApplication sharedApplication] registerForRemoteNotifications];
            UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound) categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }else{
        //ios8之前
            [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
        }
    }
}

#pragma mark--UNUserNotificationCenterDelegate
- (void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    //应用在前台收到通知
    NSLog(@"========%@", notification);
    //如果需要在应用在前台也展示通知
    completionHandler(UNNotificationPresentationOptionBadge|UNNotificationPresentationOptionSound|UNNotificationPresentationOptionAlert);
}
//点击通知进入应用

- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)())completionHandler{

    NSString * message = response.notification.request.content.body;
    if ([response isKindOfClass:[UNTextInputNotificationResponse class]]) {
        message = ((UNTextInputNotificationResponse *)response).userText;
    }
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:response.actionIdentifier message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil];
    [alert show];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
