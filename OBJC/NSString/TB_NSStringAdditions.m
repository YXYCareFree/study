//
//  TB_NSStringAdditions.m
//  TBCore
//
//  Created by Tim Cao on 12-12-12.
//  Copyright (c) 2012年 Taobao.com. All rights reserved.
//

#import "TB_NSStringAdditions.h"

@implementation NSString (TBAdditions)

///////////////////////////////////////////////////////////////////////////////////////////////////
/**
 * Copied and pasted from http://www.mail-archive.com/cocoa-dev@lists.apple.com/msg28175.html
 * Deprecated
 */
- (NSDictionary*)tbQueryDictionaryUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        if (!pairString) {
            [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
            continue;
        }
//        NSArray* kvPair = [pairString componentsSeparatedByString:@"="]; // modify by Tim Cao 2012/08/14, custom separator
        NSMutableArray* kvPair = [NSMutableArray array];
        NSInteger equalSignPosition = [pairString rangeOfString:@"="].location;
        if (equalSignPosition == NSNotFound) {
            [kvPair addObject:pairString];
            
        } else {
            [kvPair addObject:[pairString substringToIndex:equalSignPosition]];
            if (equalSignPosition != pairString.length-1)
                [kvPair addObject:[pairString substringFromIndex:equalSignPosition+1]];
        }
        if (kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSString* value = [[kvPair objectAtIndex:1]
                               stringByReplacingPercentEscapesUsingEncoding:encoding];
            if (key && value) {
                // add by Tim Cao 2012/08/14, avoid nil value(wrong encoding) to be added to dictionary
                [pairs setObject:value forKey:key];
            }
        }
    }
    
    return [NSDictionary dictionaryWithDictionary:pairs];
}

- (NSString*)tbUrlEncoded {
    CFStringRef cfUrlEncodedString = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                             (CFStringRef)self,NULL,
                                                                             (CFStringRef)@"!#$%&'()*+,/:;=?@[]",
                                                                             kCFStringEncodingUTF8);
    
    NSString *urlEncoded = [NSString stringWithString:(__bridge NSString*)cfUrlEncodedString];
    CFRelease(cfUrlEncodedString);
    return urlEncoded;
}


- (NSString*)stringByAddingQueryDictionary:(NSDictionary*)query {
    NSMutableArray* pairs = [NSMutableArray array];
    for (NSString* key in [query keyEnumerator]) {
        NSString* value = [query objectForKey:key];
        value = [value stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
        value = [value stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        NSString* pair = [NSString stringWithFormat:@"%@=%@", key, value];
        [pairs addObject:pair];
    }
    
    NSString* params = [pairs componentsJoinedByString:@"&"];
    if ([self rangeOfString:@"?"].location == NSNotFound) {
        return [self stringByAppendingFormat:@"?%@", params];
        
    } else {
        return [self stringByAppendingFormat:@"&%@", params];
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)tbStringByAddingURLEncodedQueryDictionary:(NSDictionary*)query {
    NSMutableDictionary* encodedQuery = [NSMutableDictionary dictionaryWithCapacity:[query count]];
    
    for (NSString* key in [query keyEnumerator]) {
//        NSParameterAssert([key respondsToSelector:@selector(urlEncoded)]);
        NSString* value = [query objectForKey:key];
        if (!value || (id)value==[NSNull null] || ![value isKindOfClass:[NSString class]]) {
            // add by Tim Cao 2012/08/14, avoid exception
            continue;
        }
//        NSParameterAssert([value respondsToSelector:@selector(urlEncoded)]);
        value = [value tbUrlEncoded];
        NSString *key1 = [key tbUrlEncoded];
        [encodedQuery setValue:value forKey:key1];
    }
    
    return [self stringByAddingQueryDictionary:encodedQuery];
}


- (NSDictionary*)tbQueryContentsUsingEncoding:(NSStringEncoding)encoding {
    NSCharacterSet* delimiterSet = [NSCharacterSet characterSetWithCharactersInString:@"&;"];
    NSMutableDictionary* pairs = [NSMutableDictionary dictionary];
    NSScanner* scanner = [[NSScanner alloc] initWithString:self];
    while (![scanner isAtEnd]) {
        NSString* pairString = nil;
        [scanner scanUpToCharactersFromSet:delimiterSet intoString:&pairString];
        [scanner scanCharactersFromSet:delimiterSet intoString:NULL];
        //    NSArray* kvPair = [pairString componentsSeparatedByString:@"="]; // modify by Tim Cao 2012/08/14, custom separator
        NSMutableArray* kvPair = [NSMutableArray array];
        NSInteger equalSignPosition = [pairString rangeOfString:@"="].location;
        if (equalSignPosition == NSNotFound) {
            [kvPair addObject:pairString];
            
        } else {
            [kvPair addObject:[pairString substringToIndex:equalSignPosition]];
            if (equalSignPosition != pairString.length-1)
                [kvPair addObject:[pairString substringFromIndex:equalSignPosition+1]];
        }
        if (kvPair.count == 1 || kvPair.count == 2) {
            NSString* key = [[kvPair objectAtIndex:0]
                             stringByReplacingPercentEscapesUsingEncoding:encoding];
            NSMutableArray* values = [pairs objectForKey:key];
            if (nil == values) {
                values = [NSMutableArray array];
                [pairs setObject:values forKey:key];
            }
            if (kvPair.count == 1) {
                [values addObject:[NSNull null]];
                
            } else if (kvPair.count == 2) {
                NSString* value = [[kvPair objectAtIndex:1]
                                   stringByReplacingPercentEscapesUsingEncoding:encoding];
                if (value) {
                    // add by Tim Cao 2012/08/14, avoid nil value(wrong encoding) to be added to dictionary
                    [values addObject:value];
                }
            }
        }
    }
    return [NSDictionary dictionaryWithDictionary:pairs];
}


- (NSStringEncoding)encodingForInputCharset:(NSString *)inputCharset{
    inputCharset = [inputCharset lowercaseString];
    if([inputCharset isEqualToString:@"utf-8"]){
        return NSUTF8StringEncoding;
    }else if([inputCharset isEqualToString:@"gbk"] || [inputCharset isEqualToString:@"gb2312"]){
        NSStringEncoding gbkEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
        return gbkEncoding;
    }else if([inputCharset isEqualToString:@"big5"]){
        NSStringEncoding bigEncoding = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingBig5_HKSCS_1999);
        return bigEncoding;
    }
    return NSUTF8StringEncoding;
}


#warning [[TBAppConfiguration sharedConfiguration] defaultEncoding]
- (NSDictionary*)tbQueryDictionaryUsingInnerInputCharsetEncoding{
    NSDictionary *utf8Dict = [self tbQueryDictionaryUsingEncoding:NSUTF8StringEncoding];
    NSString *charSet = [utf8Dict objectForKey:@"_input_charset"];
    if(charSet.length > 0){
        NSDictionary *charSetDict = [self tbQueryDictionaryUsingEncoding:[self encodingForInputCharset:charSet]];
        return charSetDict;
    }else{
        return utf8Dict;
    }
}


- (NSString *)urlTag
{
    NSRange rang = [self rangeOfString:@"?"];
    if (rang.location != NSNotFound) {
        NSString *result = [self substringToIndex:rang.location];
        return result;
    }
    return self;
}
@end
