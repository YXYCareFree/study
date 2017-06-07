//
//  YXYSafeStorage.m
//  SafeStorage
//
//  Created by beyondSoft on 16/8/1.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import "YXYSafeStorage.h"

@interface YXYSafeStorage ()

@property (nonatomic, strong) NSString * saveRootPath;

@property (nonatomic, strong) NSUserDefaults * defaults;
@end

@implementation YXYSafeStorage

+ (instancetype)shareSafeStorage{

    static YXYSafeStorage * storage = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        storage = [[YXYSafeStorage alloc] init];
//        storage.saveRootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        storage.defaults = [NSUserDefaults standardUserDefaults];
    });
    return storage;
}

- (void)saveObject:(id)object forKey:(NSString *)key{

    NSAssert(key, @"safeStorage key不能为空");
    NSData * data = [NSKeyedArchiver archivedDataWithRootObject:object];

    [self.defaults setObject:data forKey:key];
    [self.defaults synchronize];
}

- (id)objectForKey:(NSString *)key{

    NSAssert(key, @"safeStorage key不能为空");
    NSData * data = [self.defaults objectForKey:key];
    return [NSKeyedUnarchiver unarchiveObjectWithData:data];
}

- (void)removeObjectForKey:(NSString *)key{

    NSAssert(key, @"safeStorage key不能为空");
    [self.defaults removeObjectForKey:key];
    [self.defaults synchronize];
}
@end
