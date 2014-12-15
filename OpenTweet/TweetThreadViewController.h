//
//  TweetThreadViewController.h
//  OpenTweet
//
//  Created by Patricia S Demorest on 12/13/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TweetThreadTableViewCell.h"

@interface TweetThreadViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
    
}

@property (nonatomic, strong) NSArray *timelineArr;
@property (nonatomic, weak) IBOutlet UITableView *tweetThreadTableView;
@property (nonatomic, strong) NSDictionary *tappedTweet;
@property (nonatomic, strong) NSArray *threadArr;
@property BOOL startOfThread;

@end
