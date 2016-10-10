//
//  WEReplyDetail.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/1/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

//{
//    "id" : 3425225,
//    "thanks" : 0,
//    "content" : "我刚才试了下，拔电源 1 秒插回去就又好了。。\u000D\u000A这才第一天用啊，昨天全新拆封的上海电信猫（中兴 EPON F450G)！\u000D\u000A怎么会这样， 1 天就要拔电源？ BUG ？\u000D\u000A机器开始用要磨合几个月才不会有问题？",
//    "content_rendered" : "我刚才试了下，拔电源 1 秒插回去就又好了。。\u000D\u003Cbr /\u003E这才第一天用啊，昨天全新拆封的上海电信猫（中兴 EPON F450G)！\u000D\u003Cbr /\u003E怎么会这样， 1 天就要拔电源？ BUG ？\u000D\u003Cbr /\u003E机器开始用要磨合几个月才不会有问题？",
//    "member" : {
//        "id" : 128909,
//        "username" : "hello2u",
//        "tagline" : "None",
//        "avatar_mini" : "//cdn.v2ex.co/gravatar/14762353ddbc0124b9e8b49cb45bb987?s=24&d=retro",
//        "avatar_normal" : "//cdn.v2ex.co/gravatar/14762353ddbc0124b9e8b49cb45bb987?s=48&d=retro",
//        "avatar_large" : "//cdn.v2ex.co/gravatar/14762353ddbc0124b9e8b49cb45bb987?s=73&d=retro"
//    },
//    "created" : 1470067495,
//    "last_modified" : 1470067495
//},

class WEReplyDetail: NSObject {
    
    var replierID:NSNumber?
    var replierName:String?
    var replierImageURL:URL?
    var content:String?
    var content_rendered:String?
    var replyTime:NSNumber?
    var member = [String: AnyObject]()
    required init(_ dic:Dictionary<String, AnyObject>) {
        super.init()
        member           = dic["member"] as! Dictionary
        replierName      = member["username"] as? String
        replierID        = member["id"] as? NSNumber
        replierImageURL  = (member["avatar_normal"] as! String).URLByAddHTTPS()
        content          = dic["content"] as? String
        content_rendered = dic["content_rendered"] as? String
        replyTime        = dic["created"] as? NSNumber
    }

}
