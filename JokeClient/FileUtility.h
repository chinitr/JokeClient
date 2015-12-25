//
//  FileUtility.h
//  JokeClient
//
//  Created by bugme on 12/22/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FileUtility : NSObject

+ (NSString*)cachePath:(NSString*)fileName;
+ (BOOL)imageCacheToPath:(NSString*)path image:(NSData*)image;
+ (UIImage*)imageDataFromPath:(NSString*)path;

@end
