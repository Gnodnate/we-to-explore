//
//  NSString+HumanFriendlyDate.m
//  weToExplore
//
//  Created by Daniel Tan on 8/2/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import "NSString+HumanFriendlyDate.h"

@implementation NSString (HumanFriendlyDate)

+ (NSString *) humanFriendlyDate:(NSDate*)timeDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *result = [dateFormatter stringFromDate:timeDate];
    
    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    
    if (timeInterval/60 < 1) {
        
        result = _L(@"Latest reply: few seconds ago", @"few seconds ago");
    }
    
    else if((temp = timeInterval/60) <60){
        
        if (temp < 2) {
            result = _L(@"Latest reply: one minute ago", @"1 Minute ago");
        } else {
            result = [NSString stringWithFormat:_L(@"Latest reply: %ld minutes ago", @"few minute ago"),temp];
        }
        
    }
    
    else if((temp = temp/60) <24){
        
        if (temp < 2) {
            result = _L(@"Latest reply: one hour ago", @"1 Minute ago");
        } else {
            result = [NSString stringWithFormat:_L(@"Latest reply: %ld hours ago", @"few Hours ago"),temp];
        }
        
    }
    
    else if((temp = temp/24) <30){
        if (temp < 2) {
            result = _L(@"Latest reply: one day ago", @"1 Minute ago");
        } else {
            result = [NSString stringWithFormat:_L(@"Latest reply: %ld days ago", @"few Days ago"),temp];
        }
    }
    
    return result;
    
}
@end