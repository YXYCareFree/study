//
//  YXYSafeStorage.h
//  SafeStorage
//
//  Created by beyondSoft on 16/8/1.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YXYSafeStorage : NSObject

+ (instancetype)shareSafeStorage;

- (void)saveObject:(id)object forKey:(NSString *)key;

- (id)objectForKey:(NSString *)key;

- (void)removeObjectForKey:(NSString *)key;

@end
