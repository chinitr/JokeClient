//
//  FileUtility.m
//  JokeClient
//
//  Created by bugme on 12/22/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "FileUtility.h"

@implementation FileUtility

+ (NSString *)cachePath:(NSString *)fileName {
    NSArray* arr = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString* path = arr[0];
    NSString* str = [NSString stringWithFormat:@"%@%@", path, fileName];
    return str;
}

+ (BOOL)imageCacheToPath:(NSString *)path image:(NSData *)image {
    BOOL ret = [image writeToFile:path atomically:YES];
    return ret;
}

+ (UIImage *)imageDataFromPath:(NSString *)path {
    BOOL exist = [[NSFileManager defaultManager] fileExistsAtPath:path];
    if (exist) {
        UIImage* img = [UIImage imageWithContentsOfFile:path];
        if (img != nil)
            return img;
    }
    return nil;
}












































@end
