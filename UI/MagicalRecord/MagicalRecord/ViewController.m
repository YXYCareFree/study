//
//  ViewController.m
//  MagicalRecord
//
//  Created by beyondSoft on 16/7/13.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "User.h"
#import "AppDelegate.h"
#import "Msg.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.



}

- (IBAction)addNew:(id)sender {

    User * user = [User MR_createEntity];
    user.name = [NSString stringWithFormat:@"%d", arc4random()%200 + 1];
    NSInteger age = arc4random()%150;
    user.age = @(age);
    user.sex = @"man";
    Msg * msg = [Msg MR_createEntity];
    msg.isComing = [NSNumber numberWithBool:YES];

    [user addMsgObject:msg];


    [MagicalRecord saveWithBlock:^(NSManagedObjectContext * _Nonnull localContext) {

    } completion:^(BOOL contextDidSave, NSError * _Nullable error) {

    }];
}

- (IBAction)query:(id)sender {

    NSArray * users = [User MR_findAll];
    for (int i = 0; i < [users count]; i++) {
        
        User * emp = users[i];
        NSSet * msgSet = emp.msg;
        NSArray * arr = [msgSet allObjects];
        for (int j = 0; j < [arr count]; j++) {

            Msg * msg = arr[j];
            NSLog(@"%@", [msg.isComing boolValue]?@"yes":@"no");

        }
      //  NSLog(@"%@", msg.isComing);
//        if ([emp.age integerValue] < 100) {
//            emp.age = @(100);
//        }
    }

}
- (IBAction)queryByAge:(id)sender {

    NSArray * users = [User MR_findAllSortedBy:@"age" ascending:YES];
    for (int i = 0; i < [users count]; i++) {
        User * emp = users[i];

        NSLog(@"%@", emp.age);
      }
}

- (IBAction)delete:(id)sender {

    NSArray * users = [User MR_findAll];
    for (int i = 0; i < [users count]; i++) {
        User * emp = users[i];
        if ([emp.age integerValue] < 100) {
            [emp MR_deleteEntity];
        }
    }
}


- (IBAction)deleteAll:(id)sender {

    [User MR_truncateAll];
    NSLog(@"\n\n\n***********************");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
