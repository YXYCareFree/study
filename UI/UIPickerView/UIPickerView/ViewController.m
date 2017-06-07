//
//  ViewController.m
//  UIPickerView
//
//  Created by beyondSoft on 16/3/24.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, strong) UIPickerView * pickerView;

@end

@implementation ViewController


- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"qwer" message:@"message" preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction * action = [UIAlertAction actionWithTitle:@"title" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {

        NSLog(@"%@", alert.textFields[0].text);
    }];
    [alert addAction:action];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

        textField.placeholder = @"请输入用户名";
    }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {

        textField.placeholder = @"密码";
    }];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

/*
    NSDictionary * dic = [NSDictionary dictionaryWithObjectsAndKeys:@"object1", @"key1", @"object2", @"key2", nil];
    NSString * str = @"22:11,21:33";
    NSLog(@"%@, %@", str, dic);
    
    UIView * bgView = [[UIView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 200)];
    UIView * titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bgView.bounds.size.width, 50)];
    UIButton * cancelBtn = [[UIButton alloc] initWithFrame:CGRectMake(10, 5, 60, 40)];
    [cancelBtn addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [titleView addSubview:cancelBtn];
    
    UIButton * confirmBtn = [[UIButton alloc] initWithFrame:CGRectMake(titleView.bounds.size.width - 70, 5, 60, 40)];
    [confirmBtn addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
    [confirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [confirmBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [titleView addSubview:confirmBtn];
    [bgView addSubview:titleView];
    
    UILabel * title = [[UILabel alloc] initWithFrame:CGRectMake(bgView.bounds.size.width / 2 - 40, 5, 80, 40)];
    title.text = @"title";
    title.textAlignment = NSTextAlignmentCenter;
    title.font = [UIFont systemFontOfSize:15];
    [bgView addSubview:title];
    
    
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, bgView.bounds.size.height - 50)];
    self.pickerView.dataSource = self;
    self.pickerView.delegate = self;
    self.pickerView.showsSelectionIndicator = YES;
    [bgView addSubview:self.pickerView];
    [self.view addSubview:bgView];
*/
}

- (void)cancel{
    
    [self.pickerView removeFromSuperview];
}
- (void)confirm{
    
    [self.pickerView selectRow:1 inComponent:1 animated:YES];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return 30;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return @"qwer";
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSLog(@"%d, %d", (int)row, (int)component);
}

//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(60, 20, 300, 50)];
//    label.text = @"1111";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.textColor = [UIColor redColor];
//    return label;
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
