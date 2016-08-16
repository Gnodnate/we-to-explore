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
    var nodeTile:String? {get}
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
    var nodeTile:String?
    
    var topicsDidChange: ((WERootViewModelProtocol) -> ())?
    
    required init(dataManager:WEDataManager) {
        self.dataManager = dataManager
    }
    func showTopics() {
        var nodeName:String? = nil
        let node = NSUserDefaults.standardUserDefaults().objectForKey(DefaultNodeName)
        if node is [String:String] {
            nodeTile = (node as! [String:String]).keys.first
            nodeName = (node as! [String:String]).values.first
        }
        self.lastSessionTask?.cancel();
        self.lastSessionTask = self.dataManager.getTopicsInNode(
            nodeName,
            success:
            { (topics:[AnyObject]!) in
                var topicDetails = [WETopicDetail]()
                for detail in topics {
                    let topicDetail:WETopicDetail = WETopicDetail(dictionary: detail as! Dictionary)
                    topicDetails.append(topicDetail)
                }
                self.topics = topicDetails
            },
            progress: { (progress:NSProgress!) in
                NSLog("Progress: %@", progress.localizedDescription)
            },
            failed: { (error:NSError!) in
                self.topics = nil
        })
    }
 
    func NodeChange(notifcation:NSNotification) {
        
    }
}
