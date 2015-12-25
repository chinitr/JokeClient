//
//  CommentsViewController.m
//  JokeClient
//
//  Created by bugme on 12/23/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import "CommentsViewController.h"
#import "HttpRequest.h"
#import "UIViewExt.h"
#import "CommnentsCell.h"

@interface CommentsViewController ()

@property (nonatomic)NSMutableArray* dataArray;
@property (nonatomic)int page;
@property (nonatomic)UIView* footerView;
@property (nonatomic)BOOL isLoading;

@end

@implementation CommentsViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.page = 1;
    self.isLoading = NO;
    self.dataArray = [[NSMutableArray alloc] init];
    self.title = @"comment";
    
    NSArray* arr = [[NSBundle mainBundle] loadNibNamed:@"LoadingView" owner:self options:nil];
    if (arr.count != 0) {
        self.footerView = arr[0];
        CGRect rc =  CGRectMake(0, 0, self.tableView.frame.size.width, 30);
        self.footerView.frame = rc;
        self.tableView.tableFooterView = self.footerView;
    }

    self.tableView.estimatedRowHeight = self.tableView.rowHeight;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    [self loadData];
}

- (void)loadData {
    self.isLoading = YES;
    NSString* url = [NSString stringWithFormat:@"http://m2.qiushibaike.com/article/%@/comments?count=20&page=%d", self.jokeid, self.page];
    [HttpRequest requestWithURL:url handler:^(NSDictionary * data) {
        if (data == nil) {
            [UIView showAlertView:@"msg" message:@"load failed"];
            return;
        }
        
        NSArray* arr = [data objectForKey:@"items"];
        if (arr.count == 0) {
            [UIView showAlertView:@"msg" message:@"no comment"];
            return;
        }
        
        [self.dataArray addObjectsFromArray:arr];
        [self.tableView reloadData];
        self.page++;
        self.isLoading = NO;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommnentsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"commentcell" forIndexPath:indexPath];
    NSDictionary* data = self.dataArray[indexPath.row];
    cell.data = data;
    return cell;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if (!self.isLoading && self.tableView.contentOffset.y >
        self.tableView.contentSize.height - self.tableView.frame.size.height) {
        [self loadData];
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NSDictionary* data = self.dataArray[indexPath.row];
//    return [CommnentsCell cellHeightByData:data];
//}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
