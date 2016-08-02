//
//  GDDataManager.h
//  weToExplore
//
//  Created by Daniel Tan on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface WEDataManager : NSObject

@property (strong, nonatomic) NSArray *topicArray;


- (void)getTopics;

- (void)getRepliesForTopic:(NSNumber *)topic
                   success:(void (^)(NSArray *array))success
                    failed:(void (^)(NSError *error))failed;

- (void)getDetailofUser:(NSNumber *)userID
                success:(void (^)(NSDictionary *dic))success
                 failed:(void (^)(NSError *error))failed;

@end
