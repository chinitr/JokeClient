//
//  JokeTableViewController.m
//  JokeClient
//
//  Created by bugme on 12/18/15.
//  Copyright © 2015 bugme. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "JokeTableViewController.h"
#import "JokeTableViewCell.h"
#import "HttpRequest.h"
#import "CommentsViewController.h"
#import "NSDictionaryExt.h"
#import "ImageViewController.h"

@interface JokeTableViewController ()

@property (nonatomic)NSMutableArray* dataArray;
@property (nonatomic)int page;
@property (nonatomic)UIView* footerView;
@property (nonatomic)BOOL isLoading;
@end

@implementation JokeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    self.isLoading = NO;
    self.jokeType = JokeTableViewControllerHot;
    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;

    NSArray* arr = [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil];
    if (arr.count != 0) {
        self.footerView = arr[0];
        CGRect rc =  CGRectMake(0, 0, self.tableView.frame.size.width, 30);
        self.footerView.frame = rc;
        self.tableView.tableFooterView = self.footerView;
    }
    
    self.dataArray = [[NSMutableArray alloc] init];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(imageViewTapped:) name:@"imageViewTapped" object:nil];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"imageViewTapped" object:nil];
}

- (void)imageViewTapped:(NSNotification*)notify {
    if (notify.object != nil && [notify.object isKindOfClass:[NSString class]]) {
        NSString* imageUrl = notify.object;
        
        ImageViewController* vc = [[ImageViewController alloc] initWithNibName:nil bundle:nil];
        vc.imageUrl = imageUrl;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

- (void)loadData {
    self.isLoading = YES;
    NSString* url = [self urlString];
    [HttpRequest requestWithURL:url handler:^(NSDictionary * jsonData) {
        if (jsonData != nil) {
            NSArray* arr = [jsonData objectForKey:@"items"];
            if (arr != nil) {
                [self.dataArray addObjectsFromArray:arr];
            }
            
            if (self.tableView != nil) {
                [self.tableView reloadData];
            }
            self.page++;
            self.isLoading = NO;
        }
    }];
}

- (NSString*)urlString {
    if (self.jokeType == JokeTableViewControllerHot) {
        return [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/suggest?count=20&page=%d", self.page];
    } else if (self.jokeType == JokeTableViewControllerLatest) {
        return [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/latest?count=20&page=%d", self.page];
    } else if (self.jokeType == JokeTableViewControllerTruth) {
        return [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/list/imgrank?count=20&page=%d", self.page];
    }
    return nil;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* data = self.dataArray[indexPath.row];
    JokeTableViewCell* cell = nil;
    if ([JokeTableViewCell isNoImage:data])
        cell = [tableView dequeueReusableCellWithIdentifier:@"joketableviewcellnoimage" forIndexPath:indexPath];
    else
        cell = [tableView dequeueReusableCellWithIdentifier:@"joketableviewcell" forIndexPath:indexPath];
    if (cell != nil) {
        cell.data = data;
    }
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.isLoading && self.tableView.contentOffset.y >
            self.tableView.contentSize.height - self.tableView.frame.size.height) {
        [self loadData];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary* data = self.dataArray[indexPath.row];
    
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CommentsViewController* vc = [storyboard instantiateViewControllerWithIdentifier:@"commentviewcontroller"];
    vc.jokeid = [data stringAttributeForKey:@"id"];
    [self.navigationController pushViewController:vc animated:YES];
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
