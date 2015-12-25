//
//  UIImageViewExt.m
//  JokeClient
//
//  Created by bugme on 12/22/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "UIImageViewExt.h"
#import "FileUtility.h"

@implementation UIImageView (UIImageViewExt)

- (void)setImage:(NSString*)urlString placeHolder:(UIImage*)placeholder {
    NSURL* url = [NSURL URLWithString:urlString];
    NSString* cacheFileName = [url lastPathComponent];
    NSString* cachePath = [FileUtility cachePath:cacheFileName];
    UIImage* image = [FileUtility imageDataFromPath:cachePath];
    if (image != nil) {
        self.image = image;
    } else {
        NSURLRequest* req = [NSURLRequest requestWithURL:url];
        NSOperationQueue* queue = [[NSOperationQueue alloc] init];
        [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
            if (connectionError != nil) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.image = placeholder;
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    UIImage* image = [UIImage imageWithData:data];
                    if (image == nil) {
                        self.image = placeholder;
                    } else {
                        self.image = image;
                        [FileUtility imageCacheToPath:cachePath image:data];
                    }
                });
            }
        }];
    }
}
























@end
