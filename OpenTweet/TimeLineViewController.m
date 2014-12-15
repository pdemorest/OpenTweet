//
//  ViewController.m
//  OpenTweet
//
//  Created by Olivier Larivain on 12/12/14.
//  Copyright (c) 2014 OpenTable. All rights reserved.
//

#import "TimeLineViewController.h"

@interface TimeLineViewController ()

@end

@implementation TimeLineViewController

@synthesize timelineArr;
@synthesize timelineTableView;


- (id)initWithCoder:(NSCoder *)aDecoder {
    
    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
        /*PSD: initWithCoder called since using Storyboard, grab array from JSON object here*/
        
        NSData *data= [[NSData alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource: @"timeline" ofType: @"json"]];
        NSError *error;
        NSDictionary  *json = [NSJSONSerialization JSONObjectWithData:data options: NSJSONReadingMutableContainers error: &error];
        timelineArr = json[@"timeline"];
        
    }
    return self;
}

- (void)viewDidLoad {
    
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    //NSLog(@"# OF CELLS: %lu", (unsigned long)[timelineArr count]);
    
    return [timelineArr count];
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /*PSD: sets height for each cell based on heights of each label subview (only the tweet label height is 
     dynamic, calculate this height using [self heightForText:ForLabel:]*/
    
    NSString *labelText = [[timelineArr objectAtIndex:indexPath.row] valueForKey:@"content"];
    TimeLineTableViewCell *cell = (TimeLineTableViewCell *)[self tableView:tableView cellForRowAtIndexPath:indexPath];
    CGFloat multiLineHeight = [self heightForText:labelText forLabel:cell.tweet];
    
    //PSD: TODO: text for label is not getting set to attributed string
    
    /*author label and date label will always fit to one line, so their heights will always be 30, add 30 for extra space above and below labels*/
    return multiLineHeight + 30 + 30 + 30;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSDictionary *tweet = [timelineArr objectAtIndex:indexPath.row];
    
    NSString *cellIdentifier = @"TimeLineCell";
    
    TimeLineTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    // Configure the cell...
    
    if (cell == nil) {
        
        cell = [[TimeLineTableViewCell alloc]
                
                initWithStyle:UITableViewCellStyleDefault
                
                reuseIdentifier:cellIdentifier];
        
    }
    
    //standard ISO-8601 format--> 2014-12-13T09:45:00-08:00
    
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss"];
    //NSString *dateStr = [self convertToUTC:[[timelineArr objectAtIndex:indexPath.row] valueForKey:@"date"]];
    /*PSD: UPDATE: Assuming that the date should probably just be displayed as local time anyways, so calculating UTC is unnecessary*/
    NSString *dateStr = [[tweet valueForKey:@"date"] substringToIndex:19];
    NSDate *myDate = [df dateFromString:dateStr];
    
    [df setDateStyle:NSDateFormatterLongStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    
    [cell.date setText:[df stringFromDate:myDate]];
    
    if ([tweet valueForKey:@"avatar"] == nil) {
        [cell.avatar setImage:[UIImage imageNamed:@"noimage.png"]];
    } else {
        __block UIImage *fetchedImage = [[UIImage alloc] init];
        dispatch_queue_t backgroundQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_queue_t mainQueue = dispatch_get_main_queue();
        dispatch_async(backgroundQueue,^{
            // background process
            fetchedImage = [UIImage imageWithData: [NSData dataWithContentsOfURL:[NSURL URLWithString:[tweet valueForKey:@"avatar"]]]];
            dispatch_async(mainQueue,^{
                // always update GUI from the main thread
                [cell.avatar setImage:fetchedImage];
            });
        });
    }
    
    [cell.author setText:[[tweet valueForKey:@"author"] substringFromIndex:1]];
    NSString *labelText = [tweet valueForKey:@"content"];
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
    
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"toTweetThreadViewController"]) {
        
        NSIndexPath *indexPath = [timelineTableView indexPathForSelectedRow];
        TweetThreadViewController *destViewController = segue.destinationViewController;
        [destViewController setTimelineArr:timelineArr];
        [destViewController setTappedTweet:[timelineArr objectAtIndex:indexPath.row]];        
    }
}

/*PSD: helper methods*/


/*TODO: this helper method not completely implemented*/
- (NSString *)convertToUTC:(NSString *)utcTime {
    
    NSMutableString *newStr = [[NSMutableString alloc] initWithCapacity:20];
    int oldTime = [[utcTime substringWithRange:NSMakeRange(11, 2)] intValue];
    int delta = [[utcTime substringWithRange:NSMakeRange(20, 2)] intValue];
    int newTime;
    if ([[utcTime substringWithRange:NSMakeRange(19, 1)] isEqualToString:@"+"]) {
        newTime = (oldTime - delta) % 24;
        if (oldTime - delta < 0) {
            //utc time is on previous day
            //but then the calendar year is modular as well -_-
        }
    } else {
        newTime = (oldTime + delta) % 24;
        if (oldTime + delta > 24) {
            //utc time is on next day
            //but then the calendar year is modular as well -_-
        }
    }
    [newStr appendString:[utcTime substringToIndex:11]];
    [newStr appendString:[NSString stringWithFormat:@"%i",newTime]];
    [newStr appendString:[utcTime substringWithRange:NSMakeRange(13, 6)]];
    //cast NSMutableString to NSString should be okay
    return newStr;
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
