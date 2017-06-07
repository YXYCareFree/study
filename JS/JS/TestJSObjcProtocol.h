//
//  TestJSObjcProtocol.h
//  JS
//
//  Created by beyondSoft on 16/5/10.
//  Copyright © 2016年 beyondSoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <JavaScriptCore/JavaScriptCore.h>

@protocol TestJSObjcProtocol <JSExport>

- (void)TestNoParameter;

- (void)TestOneParameter:(NSString *)message;

- (void)TestTwoParameters:(NSString *)message1 SecondParameter:(NSString *)message2;

@end

