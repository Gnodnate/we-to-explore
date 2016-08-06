//
//  WERootViewModel.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/6/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

/// Root View Model Protocol
@objc protocol WERootViewModelProtocol {
    var topics:[WETopicDetail]? { get}
    var topicsDidChange: ((WERootViewModelProtocol) -> ())? { get set }
    init(dataManager:WEDataManager)
    func showTopics()
}

/// Root View Model
class WERootViewModel: NSObject,WERootViewModelProtocol  {
    let dataManager:WEDataManager
    var lastSessionTask:NSURLSessionTask?
    var topics: [WETopicDetail]?{
        didSet {
            self.topicsDidChange?(self)
        }
    }
    var topicsDidChange: ((WERootViewModelProtocol) -> ())?
    
    required init(dataManager:WEDataManager) {
        self.dataManager = dataManager
    }
    func showTopics() {
        self.lastSessionTask?.cancel();
        self.lastSessionTask = self.dataManager.getTopicsSucess({ (topics:[AnyObject]!) in
            var topicDetails = [WETopicDetail]()
            for detail in topics {
                let topicDetail:WETopicDetail = WETopicDetail(dictionary: detail as! Dictionary)
                topicDetails.append(topicDetail)
            }
            self.topics = topicDetails
            }, progress: { (progress:NSProgress!) in
                NSLog("Progress: %@", progress.localizedDescription)
            },failed: { (error:NSError!) in
                self.topics = nil
        })
    }
    
}
