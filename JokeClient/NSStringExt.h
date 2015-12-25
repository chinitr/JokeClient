//
//  NSStringExt.h
//  JokeClient
//
//  Created by bugme on 12/22/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (NSStringExt)

- (CGFloat)stringHeightWith:(CGFloat)fontSize width:(CGFloat)width;
- (NSString*)dateStringFromTimestamp:(NSString*)timeStamp;

@end
