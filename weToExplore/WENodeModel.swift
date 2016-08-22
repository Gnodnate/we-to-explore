//
//  WENodeModel.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import Ji
class WENode: NSObject {
    var ID:Int?
    var name:String?
    required init(nodeJiNode:JiNode) {
        name = nodeJiNode.content
        if let href = nodeJiNode["href"] {
            if let range = href.rangeOfString("go/") {
                ID = Int(href.substringFromIndex(range.endIndex))
            }
        }
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
public class WENodeModel: NSObject {
    
    class func getNode(block:Bool,
                       completeFunc:[WENodeGroup] -> Void) {
        var nodeGroupArray = [WENodeGroup]()
        
        WEDataManager.getHTML{ responseData in
            let ji = Ji(htmlData: responseData)
            if let jiNodeArray = ji?.xPath("//*[@id='Wrapper']/div/div[@class='box'][last()]/div/table/tr") {
                for groupNodeJiNode in jiNodeArray {
                    nodeGroupArray.append(WENodeGroup(groupNode: groupNodeJiNode))
                }
                completeFunc(nodeGroupArray)
            }
        }
    }

}
