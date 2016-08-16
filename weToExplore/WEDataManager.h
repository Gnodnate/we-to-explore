//
//  GDDataManager.h
//  weToExplore
//
//  Created by Daniel Tan on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    HTTPGET,
    HTTPPOST,
    JSON,
} URLMethod;

#define DefaultNodeName @"DefaultNodeName"

@interface WEDataManager : NSObject

- (NSURLSessionDataTask *)getAllNodeSuccess:(void (^)(NSArray *array))success
                                     failed:(void (^)(NSError *error))failed;

- (NSURLSessionDataTask *)getCommonNodeSuccess:(void (^)(NSString *string))success
                                        failed:(void (^)(NSError *error))failed;

- (NSURLSessionDataTask *)getTopicsInNode:(NSString*)nodeName
                                   Success:(void (^)(NSArray *topics))sucess
                                 progress:(void (^)(NSProgress *progress))Progress
                                   failed:(void (^)(NSError *error))failed;

- (NSURLSessionDataTask *)getRepliesForTopic:(NSNumber *)topic
                   success:(void (^)(NSArray *array))success
                    failed:(void (^)(NSError *error))failed;

- (NSURLSessionDataTask *)getDetailofUser:(NSNumber *)userID
                success:(void (^)(NSDictionary *dic))success
                 failed:(void (^)(NSError *error))failed;

@end
