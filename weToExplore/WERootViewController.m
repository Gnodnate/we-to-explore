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
#import "NSString+HumanFriendlyDate.h"

#define TopicCellID  @"TopicCellID"

@interface WERootViewController ()
@property (nonatomic, strong, retain) WEDataManager *dataManager;
@property (nonatomic, strong, retain) id<WERootViewModelProtocol> viewModel;
@property (nonatomic, strong, retain) RefreshActivityIndicator *refreshIndicator;
@property (nonatomic, copy) NSArray *topicDetails;

@end

@implementation WERootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
    
    
    // Hide unsed cell
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [self.tableView setTableFooterView:view];
    

    self.refreshIndicator = [[RefreshActivityIndicator alloc] init];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
//    refreshControl.attributedTitle = [[NSAttributedString alloc] initWithString:_L(@"Refreshing...", @"Refreshing")];
    [refreshControl addTarget:self action:@selector(pullToRefresh:) forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
    
    // dataManager
    _dataManager = [[WEDataManager alloc] init];
    //view Model
    _viewModel = [[WERootViewModel alloc] initWithDataManager:_dataManager];
    __weak WERootViewController* weakSelf = self;
    self.viewModel.topicsDidChange = ^(id <WERootViewModelProtocol> viewModel) {
        weakSelf.topicDetails = viewModel.topics;
        [weakSelf.refreshControl endRefreshing];
        [weakSelf.refreshIndicator stopActivityIndicator];
        [weakSelf.tableView reloadData];
    };
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    [self pullToRefresh:nil];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pull to refresh

- (IBAction)pullToRefresh:(id)sender {
    [self.refreshIndicator startActivityIndicator:[UIApplication sharedApplication].keyWindow];
    [self.viewModel showTopics];

}


#pragma mark - tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WETopicSummaryCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellID];
    
    if (!cell) {
        cell = [[WETopicSummaryCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TopicCellID];
    }
    
    if (indexPath.row < self.topicDetails.count) {
        [cell setTopicDetail:self.topicDetails[indexPath.row]];
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return  cell;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.topicDetails.count;
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
