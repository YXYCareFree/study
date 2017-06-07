//
//  ViewController.m
//  Copy
//
//  Created by beyondSoft on 16/5/5.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "ViewController.h"
#import "Person.h"

@interface ViewController ()

@property (nonatomic, strong) NSString * sStr;

@property (nonatomic, copy) NSString * cStr;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self createPerson];
}

- (void)createPerson{
    
    NSString * str = @"str";
    NSMutableString * mutabStr = [NSMutableString stringWithFormat:@"mutable%@", str];
    
    Person * person = [Person new];
    person.copysStr = str;
    person.strongStr = str;
    NSLog(@"copysStr==%@, strongStr==%@, %p, %p", person.copysStr, person.strongStr, str, &str);
    str = @"xiugai";
    NSLog(@"修改了str");
    NSLog(@"copysStr==%@, strongStr==%@, %p, %p", person.copysStr, person.strongStr, str, &str);

    Person * p1 = [Person new];
    p1.copysStr = mutabStr;
    p1.strongStr = mutabStr;
    NSLog(@"copysStr==%@, strongStr==%@, %p, %p", p1.copysStr, p1.strongStr, mutabStr, &mutabStr);
    NSLog(@"修改了mutabStr");
    [mutabStr appendString:@"ssxxx"];
    NSLog(@"copysStr==%@, strongStr==%@, %p, %p", p1.copysStr, p1.strongStr, mutabStr, &mutabStr);

}

- (void)testCopy{
    //对于NSArray来说copy与mutableCopy效果都是一样的，唯一的区别就是copy之后的copyArray元素地址和array是一致的,不管copy对象是否可变，返回的都是NSSArray类型，而mutableCopy之后的元素地址是不一样的,且返回的对象既可以是NSArray也可以是NSMutableArray，但是copy和mutableCopy之后，无论是修改array的值还是修改copy和mutableCopy的值，都是互相不影响的
    
    //    NSMutableString * str = [NSMutableString stringWithFormat:@"123445"];
    NSString * str = @"123445";
    _sStr = str;
    _cStr = str;
    
    NSLog(@"str==%p, &str==%p", str, &str);
    NSLog(@"Cstr==%p, &Cstr==%p", _cStr, &_cStr);
    NSLog(@"Sstr==%p, &Sstr==%p", _sStr, &_sStr);
    
    NSLog(@"修改cStr的值，原始值为123445");
    _cStr = @"11";
    NSLog(@"str==%@", str);
    NSLog(@"cStr==%@", _cStr);
    NSLog(@"sStr==%@", _sStr);
    NSLog(@"str==%p, &str==%p", str, &str);
    NSLog(@"Cstr==%p, &Cstr==%p", _cStr, &_cStr);
    NSLog(@"Sstr==%p, &Sstr==%p", _sStr, &_sStr);
    
    NSLog(@"修改str的值为str");
    str = @"str";
    NSLog(@"str==%@", str);
    NSLog(@"cStr==%@", _cStr);
    NSLog(@"sStr==%@", _sStr);
    NSLog(@"str==%p, &str==%p", str, &str);
    NSLog(@"Cstr==%p, &Cstr==%p", _cStr, &_cStr);
    NSLog(@"Sstr==%p, &Sstr==%p", _sStr, &_sStr);
    
    NSLog(@"修改sStr值为sStr");
    _sStr = @"sStr";
    NSLog(@"str==%@", str);
    NSLog(@"cStr==%@", _cStr);
    NSLog(@"sStr==%@", _sStr);
    NSLog(@"str==%p, &str==%p", str, &str);
    NSLog(@"Cstr==%p, &Cstr==%p", _cStr, &_cStr);
    NSLog(@"Sstr==%p, &Sstr==%p", _sStr, &_sStr);

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
