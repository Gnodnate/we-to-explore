//
//  WEMemberInfo.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/20/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit

//    "member" : {
//        "id" : 2089,
//        "username" : "wolfan",
//        "tagline" : "新疆新疆新疆人家想到新疆娶个妹纸~！",
//        "avatar_mini" : "//cdn.v2ex.co/avatar/bf42/4cb7/2089_mini.png?m=1415852720",
//        "avatar_normal" : "//cdn.v2ex.co/avatar/bf42/4cb7/2089_normal.png?m=1415852720",
//        "avatar_large" : "//cdn.v2ex.co/avatar/bf42/4cb7/2089_large.png?m=1415852720"
//    },

class WEMemberInfo: NSObject {
    var ID:Int?
    var name:String?
    var avatar_mini:NSURL?
    var avatar_normal:NSURL?
    var avatar_large:NSURL?
    init(dic: [String:AnyObject]) {
        ID            = dic["id"] as? Int
        name          = dic["username"] as? String
        avatar_mini   = (dic["avatar_mini"] as? String)?.URLByAddHTTPS()
        avatar_normal = (dic["avatar_normal"] as? String)?.URLByAddHTTPS()
        avatar_large  = (dic["avatar_large"] as? String)?.URLByAddHTTPS()
    }

}
