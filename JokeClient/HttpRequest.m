//
//  HttpRequest.m
//  JokeClient
//
//  Created by bugme on 12/18/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "HttpRequest.h"

@implementation HttpRequest

+ (void)requestWithURL:(NSString *)url handler:(httpCompletionHandler)handler {
    NSURL* URL = [NSURL URLWithString:url];
    NSURLRequest* req = [NSURLRequest requestWithURL:URL];
    NSOperationQueue* queue = [[NSOperationQueue alloc] init];
    [NSURLConnection sendAsynchronousRequest:req queue:queue completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        if (connectionError != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(nil);
            });
        } else {
            NSDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            dispatch_async(dispatch_get_main_queue(), ^{
                handler(jsonData);
            });
        }
    }];
}

@end
