//
//  HttpRequest.h
//  JokeClient
//
//  Created by bugme on 12/18/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^httpCompletionHandler)(NSDictionary*);

@interface HttpRequest : NSObject

+ (void)requestWithURL:(NSString*)url handler:(httpCompletionHandler)handler;

@end
