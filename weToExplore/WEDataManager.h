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

@end
