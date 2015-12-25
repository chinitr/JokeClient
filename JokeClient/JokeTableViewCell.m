//
//  JokeTableViewCell.m
//  JokeClient
//
//  Created by bugme on 12/18/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "JokeTableViewCell.h"
#import "NSDictionaryExt.h"
#import "NSStringExt.h"
#import "UIImageViewExt.h"
#import "UIViewExt.h"


@interface JokeTableViewCell ()
@property (nonatomic)NSString* largeImageUrl;
@end

@implementation JokeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.largeImageUrl = @"";
    UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imageViewTapped:)];
    tap.numberOfTouchesRequired = 1;
    tap.numberOfTapsRequired = 1;
    [self.pictureView addGestureRecognizer:tap];
}

- (void)setData:(NSDictionary *)data {
    _data = data;
    [self initControls];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)initControls {
    if (self.data == nil)
        return;

    NSObject* user = [self.data objectForKey:@"user"];
    if (user != nil && [user isKindOfClass:[NSDictionary class]]) {
        NSDictionary* userDict = (NSDictionary*)user;
        
        NSString* name = [userDict objectForKey:@"login"];
        self.nickLabel.text = name;
        
        NSObject* icon = [userDict objectForKey:@"icon"];
        if (icon != nil && [icon isKindOfClass:[NSString class]]) {
            NSString* userIcon = (NSString*)icon;
            NSObject* idNumber = [userDict objectForKey:@"id"];
            if (idNumber != nil && [idNumber isKindOfClass:[NSNumber class]]) {
                NSNumber* num = (NSNumber*)idNumber;
                NSString* userid = num.stringValue;
                NSString* prefixUserid = [userid substringToIndex:userid.length - 4];
                
                NSString* userImageUrl = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/avtnew/%@/%@/medium/%@", prefixUserid, userid, userIcon];
                [self.avatarView setImage:userImageUrl placeHolder:[UIImage imageNamed:@"avatar.jpg"]];
            }
        } else {
            self.avatarView.image = [UIImage imageNamed:@"avatar.jpg"];
        }
    } else {
        self.nickLabel.text = @"no name";
        self.avatarView.image = [UIImage imageNamed:@"avatar.jpg"];
    }
    
    NSString* content = [self.data stringAttributeForKey:@"content"];
    self.contentLabel.text = content;
    
    NSString* imgSrc = [self.data stringAttributeForKey:@"image"];
    if (imgSrc.length == 0) {
    } else {
        NSString* imageid = [self.data stringAttributeForKey:@"id"];
        NSString* prefiximageid = [imageid substringToIndex:imageid.length - 4];
        NSString* imageUrl = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/pictures/%@/%@/small/%@", prefiximageid, imageid, imgSrc];
        self.pictureView.hidden = NO;
        [self.pictureView setImage:imageUrl placeHolder:[UIImage imageNamed:@"avatar.jpg"]];
        self.largeImageUrl = [NSString stringWithFormat:@"http://pic.qiushibaike.com/system/pictures/%@/%@/medium/%@", prefiximageid, imageid, imgSrc];
    }
    
    NSObject* votes = [self.data objectForKey:@"votes"];
    if (votes != nil && [votes isKindOfClass:[NSDictionary class]]) {
        NSDictionary* votesDict = [self.data objectForKey:@"votes"];
        NSString* like = [votesDict stringAttributeForKey:@"up"];
        NSString* dislike = [votesDict stringAttributeForKey:@"down"];
        self.likeLabel.text = [NSString stringWithFormat:@"顶(%@)", like];
        self.dislikeLabel.text = [NSString stringWithFormat:@"踩(%@)", dislike];
    } else {
        self.likeLabel.text = @"顶(0)";
        self.dislikeLabel.text = @"踩(0)";
    }
    
    NSString* commentCount = [self.data stringAttributeForKey:@"comments_count"];
    self.commentLabel.text = [NSString stringWithFormat:@"评论(%@)", commentCount];

}

+ (BOOL)isNoImage:(NSDictionary *)data {
    NSString* imgSrc = [data stringAttributeForKey:@"image"];
    if (imgSrc.length == 0)
        return YES;
    return NO;
}

- (void)imageViewTapped:(UITapGestureRecognizer*)tap {
    if (self.largeImageUrl.length == 0)
        return;
    NSNotificationCenter* center = [NSNotificationCenter defaultCenter];
    [center postNotificationName:@"imageViewTapped" object:self.largeImageUrl];
}

@end
