//
//  NSDictionaryExt.m
//  JokeClient
//
//  Created by bugme on 12/22/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "NSDictionaryExt.h"

@implementation NSDictionary (NSDictionaryExt)

- (NSString *)stringAttributeForKey:(NSString *)key {
    NSObject* obj = [self objectForKey:key];
    if ([obj isKindOfClass:[NSNumber class]]) {
        NSNumber* num = (NSNumber*)obj;
        return num.stringValue;
    }
    if ([obj isKindOfClass:[NSString class]]) {
        NSString* str = (NSString*)obj;
        return str;
    }
    
    return @"";
}

@end
