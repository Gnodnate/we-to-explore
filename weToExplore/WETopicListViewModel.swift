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
    var topics:[WETopicDetail]! { get}
    var topicsDidChange: ((WETopicListViewModelProtocol) -> ())? { get set }
    func showTopics(_ nodeName:String)
}

/// Root View Model
class WETopicListViewModel: NSObject,WETopicListViewModelProtocol  {
    var lastSessionTask:URLSessionTask?
    var topics = [WETopicDetail]() {
        didSet {
            self.topicsDidChange?(self)
        }
    }
   
    var topicsDidChange: ((WETopicListViewModelProtocol) -> ())?
    
    func showTopics(_ nodeName:String) {
        self.lastSessionTask?.cancel()
        if defaultNodes.keys.contains(nodeName) { // default tab
            WEDataManager.getHTML(parameters: ["tab" : nodeName as AnyObject], block: true) { (responseHTML) in
                self.topics.removeAll()
                let ji = Ji(htmlData: responseHTML as Data)
                if let jiNodeArray = ji?.xPath("//*[@id='Wrapper']/div/div/div[@class='cell item']/table/tr") {
                    for node in jiNodeArray {
                        let topicDetail = WETopicDetail(jiNode: node)
                        self.topics.append(topicDetail)
                    }
                }
            }
        } else { // node
            WEDataManager.getJSON("api/topics/show.json",
                                  parameters: ["node_name": nodeName as AnyObject,
                                    "p": 0 as AnyObject],
                                  block: true,
                                  complete: { (responseJSON) in
                                    self.topics.removeAll()
                                    for json in responseJSON {
                                        let topicDetail = WETopicDetail(dic: json)
                                        self.topics.append(topicDetail)
                                    }
            })
        }

    }
}
