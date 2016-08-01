//
//  WETopicCell.m
//  weToExplore
//
//  Created by Daniel Tan on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import "WETopicSummaryCell.h"
#import "WETopicDetail.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSString+HumanFriendlyDate.h"

@interface WETopicSummaryCell ()
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *topicReplies;
@property (weak, nonatomic) IBOutlet UILabel *topicTitle;
@property (weak, nonatomic) IBOutlet UILabel *nodeName;

@end

@implementation WETopicSummaryCell

- (void)setTopicDetail:(WETopicDetail *)topicDetail
{
    if (![_topicDetail isEqual:topicDetail]) {
        _topicDetail = topicDetail;
        
        NSString *memberIconURLString = [topicDetail.memberInfo objectForKey:@"avatar_normal"];
        if ([memberIconURLString hasPrefix:@"//"]){
            memberIconURLString = [NSString stringWithFormat:@"https:%@", memberIconURLString];
        }
        [self.userImageView  sd_setImageWithURL:[NSURL URLWithString: memberIconURLString]];

        self.userName.text = [NSString stringWithFormat:_L(@"by %@", @"the blog is from who"), [topicDetail.memberInfo objectForKey:@"username"]];
        self.topicReplies.text = [NSString stringWithFormat:_L(@"reply: %@", "replies"), topicDetail.topicReplies];
        self.nodeName.text  = [topicDetail.nodeInfo objectForKey:@"title"];
        self.topicTitle.text = topicDetail.topicTitle;
    }
}
@end
