//
//  AppDelegate.m
//  UserNotification
//
//  Created by beyondSoft on 16/9/26.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "AppDelegate.h"
#import <UserNotifications/UserNotifications.h>
#import "CustomNotificationCategory.h"
#import "ViewController.h"

#define IOS8_9  ([UIDevice currentDevice].systemVersion.floatValue >= 8.0 && [UIDevice currentDevice].systemVersion.floatValue < 10.0)
#define IOS10   ([UIDevice currentDevice].systemVersion.floatValue >= 10.0)

@interface AppDelegate ()<UNUserNotificationCenterDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {

//    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    _window.rootViewController = [ViewController new];
//    _window.backgroundColor = [UIColor whiteColor];
//    [_window makeKeyAndVisible];

    [self initNotification];

    [CustomNotificationCategory registerNotificationCategory];

    return YES;
}

- (void)initNotification{

    if (IOS10) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];

        UNUserNotificationCenter * center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:UNAuthorizationOptionBadge | UNAuthorizationOptionAlert | UNAuthorizationOptionSound completionHandler:^(BOOL granted, NSError * _Nullable error) {

            if (!error) {
                NSLog(@"success");
            }
        }];
    }else{

        if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerForRemoteNotifications)]) {

            [[UIApplication sharedApplication] registerForRemoteNotifications];
            UIUserNotificationSettings * settings = [UIUserNotificationSettings settingsForTypes:(UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound) categories:nil];
            [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
        }else{
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

#pragma mark--注册APNS和获取token
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken NS_AVAILABLE_IOS(3_0){
    NSLog(@"deviceToken:%@",deviceToken);
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error NS_AVAILABLE_IOS(3_0){
    //NSLog(@"didFailToRegisterForRemoteNotificationsWithError:%@",error);
    NSLog(@"%s", __FUNCTION__);
}

//当程序在后台收到推送时，如果info.plist中配置了UIBackgroundModes会调用
-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler{

}
//在前台收到通知时，会调用下面这个方法,可以在这个方法里面实现收到通知时刷新或跳转界面的功能；程序在前台收到推送时通知栏不会弹出推送信息
//用户点击通知栏信息进入程序会调用此方法，所以在此方法里面需要根据程序在前台还是后台application.applicationState来执行不同操作
-(void)application:(UIApplication*)application didReceiveRemoteNotification:(NSDictionary*)userInfo{
    NSLog(@"%s", __FUNCTION__);
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    NSLog(@"%s", __FUNCTION__);
    NSLog(@"%@", notification.alertBody);
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
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
