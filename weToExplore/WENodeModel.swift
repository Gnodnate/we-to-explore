//
//  WENodeModel.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import Ji
class WENode {
    var name:String?
    var title:String?
    init(nodeJiNode:JiNode) {
        title = nodeJiNode.content
        if let href = nodeJiNode["href"] {
            if let range = href.range(of: "go/") {
                name = href.substring(from: range.upperBound)
            }
        }
    }
    init(Title:String?, Name:String?) {
        title = Title
        name = Name
    }
}
class WENodeGroup: NSObject {
    var Name:String?
    var nodeArray = [WENode]()
    required init(groupNode:JiNode) {
        Name = groupNode.xPath("./td[1]/span").first?.content
        for node in groupNode.xPath("./td[2]/a") {
            nodeArray.append(WENode(nodeJiNode: node))
        }
    }
}
open class WENodeModel: NSObject {
    
    class func getNode(_ block:Bool,
                       completeFunc:@escaping ([WENodeGroup]) -> Void) {
        var nodeGroupArray = [WENodeGroup]()
        
        WEDataManager.getHTML{ responseData in
            let ji = Ji(htmlData: responseData as Data)
            if let jiNodeArray = ji?.xPath("//*[@id='Wrapper']/div/div[@class='box'][last()]/div/table/tr") {
                for groupNodeJiNode in jiNodeArray {
                    nodeGroupArray.append(WENodeGroup(groupNode: groupNodeJiNode))
                }
                completeFunc(nodeGroupArray)
            }
        }
    }

}
