//
//  ImageZoomingView.m
//  JokeClient
//
//  Created by bugme on 12/23/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "ImageZoomingView.h"
#import "UIImageViewExt.h"

@interface ImageZoomingView ()

@property (nonatomic)UIImageView* imageView;
@property (nonatomic)UIImage* placeHolder;

@end

@implementation ImageZoomingView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self != nil) {
        
        self.delegate = self;
        _placeHolder = [UIImage imageNamed:@"avatar.jpg"];
        
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.imageView];
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.backgroundColor = [UIColor clearColor];
        self.minimumZoomScale = 1;
        self.maximumZoomScale = 3;
        
        UITapGestureRecognizer* tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapped:)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)doubleTapped:(UITapGestureRecognizer*)sender {
    if (self.zoomScale > 1.0) {
        [self setZoomScale:1.0 animated:YES];
    } else {
        CGPoint point = [sender locationInView:self];
        [self zoomToRect:CGRectMake(point.x - 50, point.y - 50,
                                    100, 100) animated:YES];
    }
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
    return self.imageView;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.imageView setImage:self.imageUrl placeHolder:self.placeHolder];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
