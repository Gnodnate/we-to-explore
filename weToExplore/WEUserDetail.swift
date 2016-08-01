//
//  WEUserDetail.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/1/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit


//{
//    "status" : "found",
//    "id" : 1,
//    "url" : "http://www.v2ex.com/member/Livid",
//    "username" : "Livid",
//    "website" : "",
//    "twitter" : "",
//    "psn" : "",
//    "github" : "",
//    "btc" : "",
//    "location" : "91789",
//    "tagline" : "Gravitated and spellbound",
//    "bio" : "I’ve managed to make something I could call my own world, over time, little by little. And when I’m inside it, I feel kind of relieved.",
//    "avatar_mini" : "//cdn.v2ex.co/avatar/c4ca/4238/1_mini.png?m=1466415272",
//    "avatar_normal" : "//cdn.v2ex.co/avatar/c4ca/4238/1_normal.png?m=1466415272",
//    "avatar_large" : "//cdn.v2ex.co/avatar/c4ca/4238/1_large.png?m=1466415272",
//    "created" : 1272203146
//}

class WEUserDetail: NSObject {
    var identity   = NSNumber()
    var url        = String()
    var name       = String()
    var website    = String()
    var github     = String()
    var location   = String()
    var tagline    = String()
    var bio        = String()
    var avatar     = String()
    var createTime = String()
    
    init(_ dic:Dictionary<String, AnyObject>) {
        identity = dic["id"] as! NSNumber
        url      = dic["url"] as! String
        name     = dic["username"] as! String
        website  = dic["website"] as! String
        github   = dic["github"] as! String
        location = dic["location"] as! String
        tagline  = dic["tagline"] as! String
        bio      = dic["bio"] as! String
        if (dic["avatar_large"] as! String).hasPrefix("//") {
            avatar = String(format: "%@", arguments: [dic["avatar_large"] as! String])
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        createTime = dateFormatter.stringFromDate(NSDate(timeIntervalSince1970: (dic["created"] as! NSNumber).doubleValue))
        
    }
}
