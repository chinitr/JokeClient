//
//  UIViewExt.h
//  JokeClient
//
//  Created by bugme on 12/22/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIView (UIViewExt)

- (CGFloat)x;
- (CGFloat)right;
- (CGFloat)y;
- (CGFloat)bottom;
- (CGFloat)width;
- (CGFloat)height;
- (void)setX:(CGFloat)x;
- (void)setRight:(CGFloat)right;
- (void)setY:(CGFloat)y;
- (void)setBottom:(CGFloat)bottom;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
+ (void)showAlertView:(NSString*)title message:(NSString*)msg;

@end
