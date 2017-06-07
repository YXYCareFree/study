//
//  ViewController.m
//  test
//
//  Created by beyondSoft on 16/7/14.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "NSData+Crypto.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIImageView *redImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.

    NSString * baseStr = @"test";
    NSData * baseData = [baseStr dataUsingEncoding:NSUTF8StringEncoding];

    NSData * encryData = [baseData dataWithMD5Hash];
    NSString * desStr = [[NSString alloc] initWithData:encryData encoding:NSUTF8StringEncoding];
    NSString * desStr1 = [[NSString alloc] initWithData:baseData encoding:NSUTF8StringEncoding];
    NSLog(@"\n原始data == %@\n加密data == %@\n使用加密data转为string == %@\n使用原始data转为sting == %@", baseData, encryData, desStr, desStr1);

    self.navigationController.navigationBar.barTintColor = [UIColor blackColor];

   // [self.imageView setImage:[self createImageWithUIColor:[UIColor redColor] CGSize:CGSizeMake(0.3, 0.1)]];
    self.redImageView.backgroundColor = [UIColor redColor];

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.baidu.com"]];
}

- (UIImage *)createImageWithUIColor:(UIColor *)color CGSize:(CGSize)size{

    UIScreen *screen = [UIScreen mainScreen];
    UIGraphicsBeginImageContextWithOptions(size, 0, screen.scale);
    [color set];
    UIRectFill(CGRectMake(0, 0, size.width, size.height));
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
