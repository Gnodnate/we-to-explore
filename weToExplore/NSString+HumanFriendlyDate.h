//
//  NSString+HumanFriendlyDate.h
//  weToExplore
//
//  Created by Daniel Tan on 8/2/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import <Foundation/Foundation.h>

#define _L(word, description) NSLocalizedString(word, description)

@interface NSString (HumanFriendlyDate)

+ (NSString *) humanFriendlyDate:(NSDate*)timeDate;

@end