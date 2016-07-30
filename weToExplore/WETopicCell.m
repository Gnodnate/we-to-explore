//
//  WETopicCell.m
//  weToExplore
//
//  Created by Daniel Tan on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import "WETopicCell.h"
#import "WETopicDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>

#define _L(word, description) NSLocalizedString(word, description)

@interface NSString (friendlyDate)

+ (NSString *) humanFriendlyDate:(NSDate*)timeDate;

@end

@implementation NSString (friendlyDate)

+ (NSString *) humanFriendlyDate:(NSDate*)timeDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];

    NSDate *currentDate = [NSDate date];
    NSTimeInterval timeInterval = [currentDate timeIntervalSinceDate:timeDate];
    
    long temp = 0;
    NSString *result;
    
    if (timeInterval/60 < 1) {
        
        result = _L(@"Latest reply: few seconds earlier", @"few seconds earlier");
    }
    
    else if((temp = timeInterval/60) <60){
        
        if (temp < 2) {
            result = _L(@"Latest reply: one minute earlier", @"1 Minute earlier");
        } else {
            result = [NSString stringWithFormat:_L(@"Latest reply: %ld minutes earlier", @"few minute earlier"),temp];
        }
        
    }
    
    else if((temp = temp/60) <24){
        
        if (temp < 2) {
            result = _L(@"Latest reply: one hour earlier", @"1 Minute earlier");
        } else {
            result = [NSString stringWithFormat:_L(@"Latest reply: %ld hours earlier", @"few Hours earlier"),temp];
        }
        
    }
    
    else if((temp = temp/24) <30){
        if (temp < 2) {
            result = _L(@"Latest reply: one day earlier", @"1 Minute earlier");
        } else {
            result = [NSString stringWithFormat:_L(@"Latest reply: %ld days earlier", @"few Days earlier"),temp];
        }
    }
    
    return result;
    
}
@end


@interface WETopicCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *topicTime;
@property (weak, nonatomic) IBOutlet UILabel *topicTitle;
@property (weak, nonatomic) IBOutlet UILabel *nodeName;

@end

@implementation WETopicCell

- (void)setTopicDetail:(WETopicDetail *)topicDetail
{
    if (![_topicDetail isEqual:topicDetail]) {
        NSString *memberIconURLString = [topicDetail.memberInfo objectForKey:@"avatar_normal"];
        __block WETopicCell *weakself = self;
        if ([memberIconURLString hasPrefix:@"//"]){
            memberIconURLString = [NSString stringWithFormat:@"https:%@", memberIconURLString];
        }
        _topicDetail = topicDetail;
        [weakself.userImageView  sd_setImageWithURL:[NSURL URLWithString: memberIconURLString] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [[SDWebImageManager sharedManager].imageCache storeImage:image forKey:memberIconURLString];
        }];

        self.userName.text = [NSString stringWithFormat:_L(@"by %@", @"the blog is from who"), [topicDetail.memberInfo objectForKey:@"username"]];
        self.topicTime.text = [NSString humanFriendlyDate:[NSDate dateWithTimeIntervalSince1970:topicDetail.createTime.integerValue]];
        self.nodeName.text  = [topicDetail.nodeInfo objectForKey:@"title"];
        self.topicTitle.text = topicDetail.topicTitle;
    }
}
@end
