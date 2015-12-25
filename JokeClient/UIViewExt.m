//
//  UIViewExt.m
//  JokeClient
//
//  Created by bugme on 12/22/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "UIViewExt.h"

@implementation UIView (UIViewExt)

- (CGFloat)x {
    return self.frame.origin.x;
}

- (CGFloat)right {
    return self.frame.origin.x + self.frame.size.width;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (CGFloat)bottom {
    return self.frame.origin.y + self.frame.size.height;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x {
    CGRect rect = self.frame;
    rect.origin.x = x;
    self.frame = rect;
}

- (void)setRight:(CGFloat)right {
    CGRect rect = self.frame;
    rect.origin.x = right - rect.size.width;
    self.frame = rect;
}

- (void)setY:(CGFloat)y {
    CGRect rect = self.frame;
    rect.origin.y = y;
    self.frame = rect;
}

- (void)setBottom:(CGFloat)bottom {
    CGRect rect = self.frame;
    rect.origin.y = bottom - rect.size.height;
    self.frame = rect;
}

- (void)setWidth:(CGFloat)width {
    CGRect rect = self.frame;
    rect.size.width = width;
    self.frame = rect;
}

- (void)setHeight:(CGFloat)height {
    CGRect rect = self.frame;
    rect.size.height = height;
    self.frame = rect;
}

+ (void)showAlertView:(NSString*)title message:(NSString*)msg {
    UIAlertView* alert = [[UIAlertView alloc] init];
    alert.title = title;
    alert.message = msg;
    [alert addButtonWithTitle:@"ok"];
    [alert show];
}

@end
