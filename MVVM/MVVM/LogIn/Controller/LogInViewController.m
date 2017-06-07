//
//  LogInViewController.m
//  MVVM
//
//  Created by beyondSoft on 16/3/30.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "LogInViewController.h"
#import "LogInViewInteractor.h"
#import "UIView+TagString.h"
#import "ViewController.h"
#import "UIButton+Block.h"

typedef void(^TestBlock)(NSString * str);

typedef void(^Block)();

@interface LogInViewController ()

@property (nonatomic, strong) LogInViewInteractor * interactor;

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    NSString * path = [[NSBundle mainBundle] pathForResource:@"1" ofType:@".json"];

    NSData * data = [NSData dataWithContentsOfFile:path];

    NSDictionary * dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
    NSLog(@"%@", dic);
//    [[UIApplication sharedApplication]keyWindow];
//    self.navigationController.navigationBar.translucent = YES;
    _interactor = [LogInViewInteractor new];
    _interactor.logInVC = self;

    [self fontCustom];
    [self viewTagString];
    [self btnBlock];
    TestBlock block;
    block = ^(NSString * str1){

        NSLog(@"%@", str1);
    };
    NSString * str = @"test";
    block(str);

    Block block1;
    block1 = ^(){
        NSLog(@"block");
    };
    block1();

}

- (void)btnBlock{

    UIButton * btn = [[UIButton alloc] initWithFrame:CGRectMake(60, 70, 200, 50)];
    [btn setTitle:@"btnBlock" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];

    [btn handleWithBlock:^{

        [btn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }];
}

- (void)viewTagString{

    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(100, 500, 100, 200)];
    view.tagString = @"string";
    view.backgroundColor = [UIColor redColor];
    NSLog(@"%p", view);
    [self.view addSubview:view];
    UIView * ve = [self.view viewWithTagString:@"string"];
    NSLog(@"%p", ve);
}

- (void)fontCustom{

    UILabel * label = [[UILabel alloc] init];
    NSLog(@"111");
    label.font = [UIFont systemFontOfSize:17];
    NSLog(@"222");
    label.frame = CGRectMake(90, 200, 300, 90);
    label.text = @"我就是我";
    UILabel * label1 = [[UILabel alloc] init];
    label1.font = [UIFont systemFontOfSize:20];
    [self.view addSubview:label];
}

- (void)dealloc{
    NSLog(@"dealloc");
}
- (IBAction)login:(id)sender {

    [self.interactor logIn];
    NSLog(@"登陆了");
    ViewController * vc = [ViewController new];

    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
