//
//  Person.h
//  Copy
//
//  Created by 杨肖宇 on 2017/5/23.
//  Copyright © 2017年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (nonatomic, copy) NSString * copysStr;

@property (nonatomic, strong) NSString * strongStr;

@end
