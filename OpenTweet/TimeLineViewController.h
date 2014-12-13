//
//  ViewController.h
//  OpenTweet
//
//  Created by Olivier Larivain on 12/12/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeLineTableViewCell.h"

@interface TimeLineViewController : UIViewController<UITableViewDataSource, UITableViewDelegate> {
    
}

@property (nonatomic, strong) NSArray *timelineArr;
@property (nonatomic, weak) IBOutlet UITableView *timelineTableView;


@end

