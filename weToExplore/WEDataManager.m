//
//  GDDataManager.m
//  weToExplore
//
//  Created by Daniel Tan on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import "WEDataManager.h"
#import "AFNetworking.h"
#import "WETopicDetail.h"

NSString *BaseURL             = @"https://www.v2ex.com/";
NSString *HotTitleShortURl    = @"api/topics/hot.json";
NSString *LatestTitleShortURL = @"api/topics/latest.json";
NSString *repliesShortURL     = @"api/replies/show.json";
NSString *userDetailShortURL  = @"api/members/show.json";
NSString *allNodeShortURL     = @"api/nodes/all.json";
NSString *showNodeShortURL    = @"api/nodes/show.json";
NSString *showTopicShortURL   = @"api/topics/show.json";



@interface WEDataManager ()

@property (nonatomic, strong) AFHTTPSessionManager *sessionManager;
@property (nonatomic, copy) NSString *nodeName;

@end

@implementation WEDataManager

@synthesize sessionManager =_sessionManager;


- (instancetype)init {
    self = [super init];
    self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BaseURL]];
    self.sessionManager.requestSerializer = [AFHTTPRequestSerializer serializer];
    return self;
}


- (NSURLSessionDataTask*) parseURLString:(NSString*)url
                              withMethod:(URLMethod)method
                          withParameters:(id)parameters
                                 success:(void (^)(NSURLSessionDataTask *dataTask, id responseObject))success
                                progress:(void (^)(NSProgress * _Nonnull))downloadProgress
                                 failure:(void (^)(NSError *error))failure  {
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    NSURLSessionDataTask *task = nil;
    switch (method) {
        case HTTPGET:
        case JSON:
        {
            if (method == HTTPGET) {
                self.sessionManager.responseSerializer = [AFHTTPResponseSerializer serializer];
            } else {
                self.sessionManager.responseSerializer = [AFJSONResponseSerializer serializer];
            }
            task = [self.sessionManager
                    GET:url
                    parameters:parameters
                    progress:nil
                    success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                        success(task, responseObject);
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                        failure(error);
                        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                    }];
            break;
        }
        case HTTPPOST:
        default:
            break;
    }

    return  task;

}

- (NSURLSessionDataTask *)getAllNodeSuccess:(void (^)(NSArray *array))success
                                     failed:(void (^)(NSError *error))failed {
    return [self parseURLString:allNodeShortURL
                     withMethod:JSON
                 withParameters:nil
                        success:^(NSURLSessionDataTask *dataTask, id responseObject) {
                            success(responseObject);
                        } progress:^(NSProgress * _Nonnull progress) {
                        } failure:^(NSError *error) {
                            failed(error);
                        }];
}

- (NSURLSessionDataTask *)getTopicsInNode:(NSString*)nodeName
                                   Success:(void (^)(NSArray *topics))success
                                 progress:(void (^)(NSProgress * progress))Progress
                                   failed:(void (^)(NSError *))failed {
    
    NSString *shortURL = LatestTitleShortURL;
    NSDictionary *parameters = nil;
    if (nil != nodeName) {
        parameters = @ {
            @"node_name": nodeName,
            @"p":@"0"
        };
        shortURL = showTopicShortURL;
    }
    return [self parseURLString:shortURL
                     withMethod:JSON
                 withParameters:parameters
                        success:^(NSURLSessionDataTask *dataTask, id responseObject) {
                            success(responseObject);
                        } progress:^(NSProgress * _Nonnull progress) {
                            Progress(progress);
                        } failure:^(NSError *error) {
                            failed(error);
                        }];
}

- (NSURLSessionDataTask *)getRepliesForTopic:(NSNumber *)topicID
                   success:(void (^)(NSArray *array))success
                    failed:(void (^)(NSError *error))failed {
    NSDictionary *parameters =  @{
                                  @"topic_id": topicID
                                  };
    return [self parseURLString:repliesShortURL
                     withMethod:JSON
                 withParameters:parameters
                 success:^(NSURLSessionDataTask *dataTask, id responseObject) {
                     success(responseObject);
                 } progress:^(NSProgress * _Nonnull progress) {
                 } failure:^(NSError *error) {
                     failed(error);
                 }];
}

- (NSURLSessionDataTask *)getDetailofUser:(NSNumber *)userID
                success:(void (^)(NSDictionary *dic))success
                 failed:(void (^)(NSError *error))failed {
    NSDictionary *parameters = @{ @"id" : userID };
    return [self parseURLString:userDetailShortURL
                     withMethod:JSON
                 withParameters:parameters
                 success:^(NSURLSessionDataTask *dataTask, id responseObject) {
                     success(responseObject);
                 } progress:^(NSProgress * _Nonnull progress) {
                 } failure:^(NSError *error) {
                     failed(error);
                 }];
}
- (NSURLSessionDataTask *)getCommonNodeSuccess:(void (^)(NSString *string))success
                                        failed:(void (^)(NSError *error))failed {
    NSDictionary *parameters = @{ @"tab" : @"nodes"};
    return [self parseURLString:@""
                     withMethod:HTTPGET
                 withParameters:parameters success:^(NSURLSessionDataTask *dataTask, id responseObject) {
                     success(responseObject);
                 } progress:^(NSProgress * progress) {
                 } failure:^(NSError *error) {
                     failed(error);
                 }];
}
@end
