//
//  WEReplyDetail.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/1/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

class WEReplyDetail: NSObject {
    
    var replierID = NSNumber()
    var replyText = String()
    var replyTime = NSNumber()

    init(_ dic:Dictionary<String, AnyObject>) {
        replierID = dic["id"] as! NSNumber
        replyText = dic["content"] as! String
        replyTime = dic["created"] as! NSNumber
    }

}
