//
//  TestModel.h
//  FMDB
//
//  Created by beyondSoft on 16/8/15.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JKDBModel.h"

@interface TestModel : JKDBModel

@property (nonatomic, copy) NSString * name;

@property (nonatomic, assign) int      age;

@property (nonatomic, copy) NSString * Description;


@end
