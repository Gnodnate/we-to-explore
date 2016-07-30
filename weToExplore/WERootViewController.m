//
//  ViewController.m
//  weToExplore
//
//  Created by Odie on 7/30/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

#import "WERootViewController.h"
#import "WETopicCell.h"
#import "WEDataManager.h"
#import "objc/Runtime.h"

#define TopicCellID  @"TopicCellID"

@interface WERootViewController ()
@property (nonatomic, strong) WEDataManager *dataManager;
@end

@implementation WERootViewController

- (void)awakeFromNib {
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.dataManager = [[WEDataManager alloc] init];
    [self registerAsObserverForDataManager:self.dataManager];
    [self.dataManager getTopics];
}

- (void)viewDidLoad {
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma KVO for dataManager

- (void)registerAsObserverForDataManager:(WEDataManager*)dataManager {
    unsigned int propertyCount = 0;
    objc_property_t *properties = class_copyPropertyList(dataManager.class, &propertyCount);
    for (unsigned int i=0; i<propertyCount; ++i) {
        [dataManager addObserver:self
                      forKeyPath:[NSString stringWithUTF8String:property_getName(properties[i])]
                         options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                         context:nil];
    }
//    [dataManager addObserver:self
//                  forKeyPath:@"topicArray"
//                     options:(NSKeyValueObservingOptionOld|NSKeyValueObservingOptionNew)
//                     context:nil];
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
        }
    }
}



#pragma mark tableview delegate
- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WETopicCell *cell = [tableView dequeueReusableCellWithIdentifier:TopicCellID];
    
    if (!cell) {
        cell = [[WETopicCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:TopicCellID];
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

@end
