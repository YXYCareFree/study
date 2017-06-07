//
//  ViewController.m
//  KeyChain
//
//  Created by beyondSoft on 16/6/1.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "KeychainItemWrapper.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
//
//    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
//    self.label.text = [ud objectForKey:@"key"];

    //KeychainItemWrapper是mrc文件，需要修改配置-fno-objc-arc
   KeychainItemWrapper * wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"myKey" accessGroup:nil];

    self.label.text = [wrapper objectForKey:(id)kSecAttrAccount];

}
- (IBAction)keyChain:(id)sender {

//    NSUserDefaults * ud = [NSUserDefaults standardUserDefaults];
//    [ud setObject:@"object" forKey:@"key"];
//    [ud synchronize];

    KeychainItemWrapper * wrapper = [[KeychainItemWrapper alloc] initWithIdentifier:@"myKey" accessGroup:nil];
    [wrapper setObject:@"account" forKey:(id)kSecAttrAccount];
    [wrapper setObject:@"1234" forKey:(id)kSecValueData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
