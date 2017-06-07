//
//  NSData+Crypto.h
//  workbench
//
//  各种数据算法
//
//  Created by 冯增亮 on 14-4-21.
//  Copyright (c) 2014年 冯增亮. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (Crypto)

/**
 Generate an md5 checksum from the receiver
 @returns An `NSData` containing the md5 digest.
 */
- (NSData *)dataWithMD5Hash;

- (NSData *)AES256EncryptWithKey:(NSString *)key;
- (NSData *)AES256DecryptWithKey:(NSString *)key;
- (NSData *)TripleDESEncryptWithKey:(NSString *)key;
- (NSData *)TripleDESDecryptWithKey:(NSString *)key;


@end
