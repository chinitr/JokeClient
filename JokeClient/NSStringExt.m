//
//  NSStringExt.m
//  JokeClient
//
//  Created by bugme on 12/22/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "NSStringExt.h"

@implementation NSString (NSStringExt)

- (CGFloat)stringHeightWith:(CGFloat)fontSize width:(CGFloat)width {
    UIFont* font = [UIFont systemFontOfSize:fontSize];
    CGSize size = CGSizeMake(width, CGFLOAT_MAX);
    NSMutableParagraphStyle* paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSMutableDictionary* attribute = [[NSMutableDictionary alloc] init];
    [attribute setObject:font forKey:[paragraphStyle copy]];
    
    NSString* text = self;
    CGRect rect = [text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attribute context:nil];
    return rect.size.height;
}

- (NSString*)dateStringFromTimestamp:(NSString*)timeStamp {
    double ts = timeStamp.doubleValue;
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyy年MM月dd日 HH:MM:ss";
    NSDate* date = [[NSDate alloc] initWithTimeIntervalSince1970:ts];
    return [formatter stringFromDate:date];    
}

@end
