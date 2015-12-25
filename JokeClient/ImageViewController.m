//
//  ImageViewController.m
//  JokeClient
//
//  Created by bugme on 12/23/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "ImageViewController.h"
#import "ImageZoomingView.h"

@interface ImageViewController ()
@property (nonatomic)ImageZoomingView* imageZoomView;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"pic";
    [self setupViews];
}

- (void)setupViews {
    self.imageZoomView = [[ImageZoomingView alloc] initWithFrame:self.view.frame];
    self.imageZoomView.imageUrl = self.imageUrl;
    [self.view addSubview:self.imageZoomView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
