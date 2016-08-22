//
//  WERootViewModel.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/6/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import Ji

/// Root View Model Protocol
@objc protocol WETopicListViewModelProtocol {
    var topics:[WETopicDetail]? { get}
//    var nodeTile:String? {get}
    var topicsDidChange: ((WETopicListViewModelProtocol) -> ())? { get set }
    func showTopics(nodeID:String)
}

/// Root View Model
class WETopicListViewModel: NSObject,WETopicListViewModelProtocol  {
    var lastSessionTask:NSURLSessionTask?
    var topics: [WETopicDetail]? {
        didSet {
            self.topicsDidChange?(self)
        }
    }
//    var nodeName:String?
//    var nodeID:String?
//    
    var topicsDidChange: ((WETopicListViewModelProtocol) -> ())?
    
    func showTopics(nodeID:String) {
        self.lastSessionTask?.cancel()
        WEDataManager.getHTML(parameters: ["tab" : nodeID], block: true) { (responseHTML) in
            let ji = Ji(htmlData: responseHTML)
            self.topics = [WETopicDetail]()
            if let jiNodeArray = ji?.xPath("//*[@id='Wrapper']/div/div/div[@class='cell item']/table/tr") {
                for node in jiNodeArray {
                    let topicDetail = WETopicDetail(jiNode: node)
                    self.topics?.append(topicDetail)
                }
            }
        }
    }
}
