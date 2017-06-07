//
//  AppDelegate.m
//  SliderController
//
//  Created by beyondSoft on 16/7/5.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "AppDelegate.h"
#import "PKRevealController.h"
#import "RightViewController.h"
#import "LeftViewController.h"
#import "MMDrawerController.h"
#import "ViewController.h"
#import "YXYNavigationController.h"

@interface AppDelegate ()<PKRevealing>
@property (nonatomic, strong) PKRevealController * revealVC;
@property (nonatomic, strong) MMDrawerController * drawVC;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    sleep(2);
    _window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];

    ViewController * frontVC = [[ViewController alloc] init];
    frontVC.view.backgroundColor = [UIColor whiteColor];
    frontVC.mmdVC = _drawVC;
    //UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:frontVC];
    YXYNavigationController * nav = [[YXYNavigationController alloc] initWithRootViewController:frontVC];

    RightViewController * rightVC = [RightViewController new];
    rightVC.view.backgroundColor = [UIColor redColor];

   // rightVC.nav = _revealVC;
    UINavigationController * rightNav = [[UINavigationController alloc] initWithRootViewController:rightVC];


    LeftViewController * leftVC = [LeftViewController new];
    //leftVC.view.backgroundColor = [UIColor grayColor];

   // UINavigationController * leftNav = [[UINavigationController alloc] initWithRootViewController:leftVC];
    YXYNavigationController * leftNav = [[YXYNavigationController alloc] initWithRootViewController:leftVC];

//    _revealVC = [PKRevealController revealControllerWithFrontViewController:frontVC leftViewController:leftVC rightViewController:rightVC];
//    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:_revealVC];

//    self.revealVC.delegate = self;
//    self.revealVC.animationDuration = 0.5;

//    self.window.rootViewController = nav;

    _drawVC = [[MMDrawerController alloc] initWithCenterViewController:nav leftDrawerViewController:leftNav rightDrawerViewController:rightNav];

    [_drawVC setShowsShadow:YES];
    [_drawVC setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [_drawVC setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [_drawVC setMaximumLeftDrawerWidth:200];

    leftVC.mmdVC = _drawVC;
    rightVC.mmdVC = _drawVC;

    _window.rootViewController = _drawVC;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)revealController:(PKRevealController *)revealController didChangeToState:(PKRevealControllerState)state
{
    NSLog(@"%@ (%d)", NSStringFromSelector(_cmd), (int)state);
}

- (void)revealController:(PKRevealController *)revealController willChangeToState:(PKRevealControllerState)next
{
    PKRevealControllerState current = revealController.state;
    NSLog(@"%@ (%d -> %d)", NSStringFromSelector(_cmd), (int)current, (int)next);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
