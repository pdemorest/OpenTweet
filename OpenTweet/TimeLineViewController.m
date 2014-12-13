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
    
    /*author label and date label will always fit to one line, so their heights will always be 30, add 30 for extra space above and below labels*/
    return multiLineHeight + 30 + 30 + 30;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
    /*PSD: changeToTimeZone will return the ^ above format, with the +/- hours accounted for (utc->timezone)*/
    NSString *dateStr = [self changeToTimeZone:[[timelineArr objectAtIndex:indexPath.row] valueForKey:@"date"]];
    NSDate *myDate = [df dateFromString:dateStr];
    
    [df setDateStyle:NSDateFormatterLongStyle];
    [df setTimeStyle:NSDateFormatterShortStyle];
    
    [cell.date setText:[df stringFromDate:myDate]];
    [cell.author setText:[[timelineArr objectAtIndex:indexPath.row] valueForKey:@"author"]];
    NSString *multilineString = [[timelineArr objectAtIndex:indexPath.row] valueForKey:@"content"];
    [cell.tweet setText:multilineString];
    
    
    return cell;
}

/*PSD: helper methods*/

- (NSString *)changeToTimeZone:(NSString *)utcTime {
    
    NSMutableString *newStr = [[NSMutableString alloc] initWithCapacity:20];
    int oldTime = [[utcTime substringWithRange:NSMakeRange(11, 2)] intValue];
    int delta = [[utcTime substringWithRange:NSMakeRange(20, 2)] intValue];
    int newTime;
    if ([[utcTime substringWithRange:NSMakeRange(19, 1)] isEqualToString:@"+"]) {
        newTime = (oldTime + delta) % 24;
    } else {
        newTime = (oldTime - delta) % 24;
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
