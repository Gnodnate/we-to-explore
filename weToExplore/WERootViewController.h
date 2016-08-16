//
//  ViewController.h
//  weToExplore
//
//  Created by Odie on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WERootViewController : UITableViewController<UITableViewDataSource, UITableViewDelegate>
- (IBAction)pullToRefresh:(id)sender;
@end

