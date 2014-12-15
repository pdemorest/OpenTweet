//
//  TweetThreadTableViewCell.m
//  OpenTweet
//
//  Created by Patricia S Demorest on 12/13/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "TweetThreadTableViewCell.h"

@implementation TweetThreadTableViewCell

@synthesize avatar;
@synthesize author;
@synthesize date;
@synthesize tweet;

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
