//
//  TweetThreadViewController.m
//  OpenTweet
//
//  Created by Patricia S Demorest on 12/13/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "TweetThreadViewController.h"

@interface TweetThreadViewController ()

@end

@implementation TweetThreadViewController

@synthesize timelineArr;
@synthesize tweetThreadTableView;
@synthesize tappedTweet;
@synthesize threadArr;
@synthesize startOfThread;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if ([tappedTweet valueForKey:@"inReplyTo"] == nil) {
        startOfThread = YES;
        NSString *startID = [[NSString alloc] initWithString:[tappedTweet valueForKey:@"id"]];
        NSMutableArray *replies = [[NSMutableArray alloc] init];
        for (NSDictionary *dict in timelineArr) {
            if ([[dict valueForKey:@"inReplyTo"] isEqualToString:startID]) {
                [replies addObject:dict];
            }
        }
        //cast from NSMutableArray to NSArray should be fine
        threadArr = replies;
    } else {
        startOfThread = NO;
        NSString *startID = [[NSString alloc] initWithString:[tappedTweet valueForKey:@"inReplyTo"]];
        for (NSDictionary *dict in timelineArr) {
            if ([[dict valueForKey:@"id"] isEqualToString:startID]) {
                NSArray *start = [[NSArray alloc] initWithObjects:dict, nil];
                threadArr = start;
                break;
            }
        }
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return 1;
    } else {
        if (startOfThread) {
            return [threadArr count];
        } else {
            return 1;
        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (startOfThread) {
        if (section == 0) {
            return @"Tapped Tweet:";
        }
        return @"Replies:";
    } else {
        if (section == 0) {
            return @"Tapped Tweet:";
        }
        return @"Replying to:";
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*PSD: sets height for each cell based on heights of each label subview (only the tweet label height is
     dynamic, calculate this height using [self heightForText:ForLabel:]*/
    
    NSString *labelText = [[NSString alloc] init];
    if (indexPath.section == 0) {
        labelText = [tappedTweet valueForKey:@"content"];
    } else {
        labelText = [[threadArr objectAtIndex:indexPath.row] valueForKey:@"content"];
    }
    TweetThreadTableViewCell *cell = (TweetThreadTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGFloat multiLineHeight = [self heightForText:labelText forLabel:cell.tweet];
    
    /*author label and date label will always fit to one line, so their heights will always be 30, add 30 for extra space above and below labels*/
    return multiLineHeight + 30 + 30 + 30;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *cellIdentifier = @"ThreadCell";
    
    
    TweetThreadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    // Configure the cell...
    
    if (cell == nil) {
        
        cell = [[TweetThreadTableViewCell alloc]
                
                initWithStyle:UITableViewCellStyleDefault
                
                reuseIdentifier:cellIdentifier];
        
    }
    
    if (indexPath.section == 0) {
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSString *dateStr = [[tappedTweet valueForKey:@"date"] substringToIndex:19];
        NSDate *myDate = [df dateFromString:dateStr];
        
        [df setDateStyle:NSDateFormatterLongStyle];
        [df setTimeStyle:NSDateFormatterShortStyle];
        
        [cell.date setText:[df stringFromDate:myDate]];
        [cell.author setText:[[tappedTweet valueForKey:@"author"] substringFromIndex:1]];
        
        if ([tappedTweet valueForKey:@"avatar"] == nil) {
            [cell.avatar setImage:[UIImage imageNamed:@"noimage.png"]];
        } else {
            __block UIImage *fetchedImage = [[UIImage alloc] init];
            dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(backgroundQueue,^{
                // background process
                fetchedImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:[tappedTweet valueForKey:@"avatar"]]]];
                dispatch_async(mainQueue,^{
                    // always update GUI from the main thread
                    [cell.avatar setImage:fetchedImage];
                });
            });
        }
        
        NSString *labelText = [tappedTweet valueForKey:@"content"];
        if ([labelText containsString:@"@"]) {
            //NSLog(@"tweet: %@", labelText);
            int start = (int)[labelText rangeOfString:@"@"].location;
            //NSLog(@"@ at index %i", start);
            int end = (int)[[labelText substringFromIndex:start] rangeOfString:@" "].location + start;
            //NSLog(@"mention ends at index %i", end);
            NSMutableAttributedString *attrContent = [[NSMutableAttributedString alloc] initWithString:labelText];
            [attrContent addAttribute:NSForegroundColorAttributeName
                                value:[UIColor blueColor]
                                range:NSMakeRange(start, end)];
            [cell.tweet setAttributedText:attrContent];
            //NSLog(@"attr text: %@", [cell.tweet attributedText]);
        } else {
            [cell.tweet setText:labelText];
        }
        
    } else {
        
        NSDictionary *tweetReply = [threadArr objectAtIndex:indexPath.row];
        
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
        NSString *dateStr = [[tweetReply valueForKey:@"date"] substringToIndex:19];
        NSDate *myDate = [df dateFromString:dateStr];
        
        [df setDateStyle:NSDateFormatterLongStyle];
        [df setTimeStyle:NSDateFormatterShortStyle];
        
        [cell.date setText:[df stringFromDate:myDate]];
        
        if ([tweetReply valueForKey:@"avatar"] == nil) {
            [cell.avatar setImage:[UIImage imageNamed:@"noimage.png"]];
        } else {
            __block UIImage *fetchedImage = [[UIImage alloc] init];
            dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
            dispatch_queue_t mainQueue = dispatch_get_main_queue();
            dispatch_async(backgroundQueue,^{
                // background process
                fetchedImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:[tweetReply valueForKey:@"avatar"]]]];
                dispatch_async(mainQueue,^{
                    // always update GUI from the main thread
                    [cell.avatar setImage:fetchedImage];
                });
            });
        }
        
        [cell.author setText:[[tweetReply valueForKey:@"author"] substringFromIndex:1]];
        
        NSString *labelText = [tweetReply valueForKey:@"content"];
        if ([labelText containsString:@"@"]) {
            /*create attributed string*/
            int start = (int)[labelText rangeOfString:@"@"].location;
            int end = (int)[[labelText substringFromIndex:start] rangeOfString:@" "].location + start;
            NSMutableAttributedString *attrContent = [[NSMutableAttributedString alloc] initWithString:labelText];
            [attrContent addAttribute:NSForegroundColorAttributeName
                                value:[UIColor blueColor]
                                range:NSMakeRange(start, end)];
            [cell.tweet setAttributedText:attrContent];
            //NSLog(@"attr text: %@", [cell.tweet attributedText]);
        } else {
            [cell.tweet setText:labelText];
        }
        
    }
    
    return cell;
}

- (CGFloat)heightForText:(NSString *)bodyText forLabel:(UILabel *)multiLineLabel {
    
    CGRect rect = [bodyText boundingRectWithSize:CGSizeMake(multiLineLabel.frame.size.width / 2, CGFLOAT_MAX)
                                         options:NSLineBreakByWordWrapping | NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName: multiLineLabel.font}
                                         context:nil];
    rect.size.width = ceil(rect.size.width);
    rect.size.height = ceil(rect.size.height);
    
    //reset frame for label
    [multiLineLabel setFrame:rect];
    
    return rect.size.height;
}



@end
