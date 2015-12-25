//
//  UIImageViewExt.h
//  JokeClient
//
//  Created by bugme on 12/22/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageView (UIImageViewExt)

- (void)setImage:(NSString*)urlString placeHolder:(UIImage*)image;

@end
