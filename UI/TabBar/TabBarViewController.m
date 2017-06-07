//
//  TabBarViewController.m
//  TabBar
//
//  Created by beyondSoft on 16/10/14.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "TabBarViewController.h"
#import "HomeViewController.h"
#import "MessageViewController.h"
#import "MineViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self initTabBarController];
}

- (void)initTabBarController{

    HomeViewController * home = [HomeViewController new];
    home.view.backgroundColor = [UIColor blueColor];
    UINavigationController * homeNav = [[UINavigationController alloc] initWithRootViewController:home];
    //可以在单独的ViewController设置NavigationController的title
    homeNav.tabBarItem.title = @"主页";
    

    MessageViewController * mess = [MessageViewController new];
    mess.view.backgroundColor = [UIColor redColor];
    UINavigationController * messNav = [[UINavigationController alloc] initWithRootViewController:mess];
    UIImage * image = [UIImage imageNamed:@"@2x"];

    messNav.tabBarItem.image = image;
    messNav.tabBarItem.imageInsets = UIEdgeInsetsMake(-10, 0, 5, 0);
    messNav.tabBarItem.title = @"消息";
    [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(rotateImage:) userInfo:messNav.tabBarItem repeats:YES];


   MineViewController * mine = [MineViewController new];
    mine.view.backgroundColor = [UIColor purpleColor];
    UINavigationController * mineNav = [[UINavigationController alloc] initWithRootViewController:mine];
   mineNav.tabBarItem.title = @"我的";

    self.viewControllers = @[homeNav, messNav, mineNav];
}

- (void)rotateImage:(NSTimer *)timer{
    UITabBarItem * item = (UITabBarItem *)timer.userInfo;
}
//- (UINavigationController *)navWithClassName:(NSString *)className{
//
//    UIViewController * vc = []
//}
@end
