//
//  WENodeInfo.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/20/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
//    "node" : {
//        "id" : 12,
//        "name" : "qna",
//        "title" : "问与答",
//        "title_alternative" : "Questions and Answers",
//        "url" : "http://www.v2ex.com/go/qna",
//        "topics" : 73432,
//        "avatar_mini" : "//cdn.v2ex.co/navatar/c20a/d4d7/12_mini.png?m=1469612548",
//        "avatar_normal" : "//cdn.v2ex.co/navatar/c20a/d4d7/12_normal.png?m=1469612548",
//        "avatar_large" : "//cdn.v2ex.co/navatar/c20a/d4d7/12_large.png?m=1469612548"
//    },
class WENodeInfo: NSObject {
    var ID:Int?
    var name:String?
    var title:String?
    var url:String?
    var avatar_mini:String?
    var avatar_normal:String?
    var avatar_large:String?
    init(dic: [String:AnyObject]) {
        ID            = dic["id"] as? Int
        name          = dic["name"] as? String
        title         = dic["title"] as? String
        url           = dic["url"] as? String
        avatar_mini   = dic["avatar_mini"] as? String
        avatar_normal = dic["avatar_normal"] as? String
        avatar_large  = dic["avatar_large"] as? String
    }
}
