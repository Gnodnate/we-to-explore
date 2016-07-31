//
//  WETopicCell.h
//  weToExplore
//
//  Created by Daniel Tan on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import <UIKit/UIKit.h>

#define _L(word, description) NSLocalizedString(word, description)


@class WETopicDetail;

@interface WETopicCell : UITableViewCell

@property (nonatomic, strong) WETopicDetail *topicDetail;

@end
