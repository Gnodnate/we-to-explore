//
//  ViewController.m
//  weToExplore
//
//  Created by Odie on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import "WERootViewController.h"
#import "WETopicSummaryCell.h"
#import "WEDataManager.h"
#import "objc/Runtime.h"
#import "weToExplore-Swift.h"

#define TopicCellID  @"TopicCellID"

@interface WERootViewController ()
@property (nonatomic, strong) WEDataManager *dataManager;
@property (nonatomic, strong) RefreshActivityIndicator *refreshIndicator;
@end

@implementation WERootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    
    // Refersh
    self.refreshIndicator = [[RefreshActivityIndicator alloc] init];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:_L(@"Refreshing...", @"Refreshing")];
    [refreshControl addTarget:self action:@selector(pullToRefresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    
    // dataManager
    self.dataManager = [[WEDataManager alloc] init];
    [self registerAsObserverForDataManager:self.dataManager];
    
    [self.refreshIndicator startActivityIndicator:self.view];
    [self.dataManager getTopics];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Pull to refresh

- (IBAction)pullToRefresh:(id)sender {
    
    [self.dataManager getTopics];
    
}

#pragma mark - KVO for dataManager

- (void)registerAsObserverForDataManager:(WEDataManager*)dataManager {
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(dataManager.class, &propertyCount);
    for (unsigned int i=0; i<propertyCount; ++i) {
        [dataManager addObserver:self
                      forKeyPath:[NSString stringWithUTF8String:property_getName(properties[i])]
                         options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                         context:nil];
    }
}

- (void)removeObserverForDataManager:(WEDataManager*)dataManager {
    [dataManager removeObserver:self forKeyPath:@"topicArray"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([object isEqual:self.dataManager]) {
        if ([keyPath isEqualToString:@"topicArray"]) {
            [self.tableView reloadData];
            if ([self.refreshControl isRefreshing]) {
                [self.refreshControl endRefreshing];
            }
            [self.refreshIndicator stopActivityIndicator:self.view];
        }
    }
}



#pragma mark - tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WETopicSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellID];
    
    if (!cell) {
        cell = [[WETopicSummaryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TopicCellID];
    }
    
    if (indexPath.row < self.dataManager.topicArray.count) {
        [cell setTopicDetail:self.dataManager.topicArray[indexPath.row]];
    }
    return  cell;
}
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.dataManager.topicArray.count;
}

#pragma mark - Segue

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {

    if ([sender isKindOfClass:[WETopicSummaryCell class]]) {
        WETopicTableViewController *destnation = segue.destinationViewController;
        [destnation setTopicDetail:((WETopicSummaryCell*)sender).topicDetail];
    }
}

@end
