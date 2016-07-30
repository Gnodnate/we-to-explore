//
//  WETopicCellDetail.h
//  weToExplore
//
//  Created by Daniel Tan on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WETopicDetail : NSObject

@property (nonatomic, copy) NSNumber *topicID;
@property (nonatomic, copy) NSString *topicTitle;
@property (nonatomic, copy) NSString *topicURL;
@property (nonatomic, copy) NSString *topicContent;
@property (nonatomic, copy) NSNumber *topicReplies;
@property (nonatomic, copy) NSDictionary *memberInfo;
@property (nonatomic, copy) NSDictionary *nodeInfo;
@property (nonatomic, copy) NSNumber *createTime;
@property (nonatomic, copy) NSNumber *replyTime;

- (instancetype)initWithDictionary:(NSDictionary*)dic;
@end
