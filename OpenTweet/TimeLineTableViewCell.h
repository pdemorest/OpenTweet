//
//  TimeLineTableViewCell.h
//  OpenTweet
//
//  Created by Patricia S Demorest on 12/12/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TimeLineTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *author;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UILabel *tweet;

@end
