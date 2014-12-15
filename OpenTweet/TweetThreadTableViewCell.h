//
//  TweetThreadTableViewCell.h
//  OpenTweet
//
//  Created by Patricia S Demorest on 12/13/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TweetThreadTableViewCell : UITableViewCell

/*PSD: write now, this class is identical to TimeLineTableViewCell (so seems unnecessary to have new class), however in future, we may want it to be formatted differently/have various other features?*/

@property (nonatomic, weak) IBOutlet UIImageView *avatar;
@property (nonatomic, weak) IBOutlet UILabel *author;
@property (nonatomic, weak) IBOutlet UILabel *date;
@property (nonatomic, weak) IBOutlet UILabel *tweet;

@end
