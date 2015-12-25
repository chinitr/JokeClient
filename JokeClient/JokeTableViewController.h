//
//  JokeTableViewController.h
//  JokeClient
//
//  Created by bugme on 12/18/15.
//  Copyright © 2015 bugme. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    JokeTableViewControllerHot,
    JokeTableViewControllerLatest,
    JokeTableViewControllerTruth,
} JokeTableViewControllerType;

@interface JokeTableViewController : UITableViewController

@property (nonatomic) JokeTableViewControllerType jokeType;

@end
