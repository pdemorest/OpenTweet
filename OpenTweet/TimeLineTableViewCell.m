//
//  TimeLineTableViewCell.m
//  OpenTweet
//
//  Created by Patricia S Demorest on 12/12/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "TimeLineTableViewCell.h"

@implementation TimeLineTableViewCell

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
