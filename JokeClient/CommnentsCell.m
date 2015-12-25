//
//  CommnentsCell.m
//  JokeClient
//
//  Created by bugme on 12/23/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "CommnentsCell.h"
#import "NSDictionaryExt.h"
#import "UIImageViewExt.h"
#import "NSStringExt.h"
#import "UIViewExt.h"

@interface CommnentsCell ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarView;
@property (weak, nonatomic) IBOutlet UILabel *nickLabel;
@property (weak, nonatomic) IBOutlet UILabel *floorLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;

@end

@implementation CommnentsCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setData:(NSDictionary *)data {
    _data = data;

    NSObject* user = [self.data objectForKey:@"user"];
    if (user != nil && [user isKindOfClass:[NSDictionary class]]) {
        NSDictionary* userDict = (NSDictionary*)user;
        NSString* name = [userDict objectForKey:@"login"];
        self.nickLabel.text = name;
        
        NSObject* icon = [userDict objectForKey:@"icon"];
        if (icon != nil && [icon isKindOfClass:[NSString class]]) {
            NSString* userIcon = (NSString*)icon;
            NSString* userid = [userDict stringAttributeForKey:@"id"];
            NSString* prefixuserid = [userid substringToIndex:3];
            NSString* userImageUrl = [NSString stringWithFormat:@"http://pic.moumentei.com/system/avtnew/%@/%@/thumb/%@", prefixuserid, userid, userIcon];
            [self.avatarView setImage:userImageUrl placeHolder:[UIImage imageNamed:@"avatar.jpg"]];
        } else {
            self.avatarView.image = [UIImage imageNamed:@"avatar.jpg"];;
        }
        
        NSString* timeStamp = [userDict stringAttributeForKey:@"created_at"];
        NSString* date = [timeStamp dateStringFromTimestamp:timeStamp];
        self.dateLabel.text = date;
    } else {
        self.nickLabel.text = @"no name";
        self.avatarView.image = [UIImage imageNamed:@"avatar.jpg"];;
        self.dateLabel.text = @"";
    }
    
    NSString* content = [self.data stringAttributeForKey:@"content"];
    self.contentLabel.text = content;
    
    NSString* floor = [self.data stringAttributeForKey:@"floor"];
    self.floorLabel.text = [NSString stringWithFormat:@"floor %@", floor];;
}

@end
