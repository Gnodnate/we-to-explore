//
//  WEDataManager.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import Alamofire

private let BaseURL = "https://www.v2ex.com/"
private let USER_AGENT = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4"
private let MOBILE_CLIENT_HEADERS = ["user-agent" : USER_AGENT]

public class WEDataManager: NSObject {
    private static let shareManager = WEDataManager()

    private override init() {
        super.init()
    }
    class func getJSON(shortURL:String="",
                 parameters:[String:AnyObject]? = nil,
                 block:Bool = false,
                 complete:[[String:AnyObject]] -> Void) -> Request {
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        return Alamofire.request(.GET,
                          BaseURL+shortURL,
                          parameters: parameters,
                          headers: MOBILE_CLIENT_HEADERS)
            .responseJSON(queue: block ? nil : dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0),
                          options: .AllowFragments,   
                          completionHandler: { response in
                            if response.result.isSuccess {
                                complete((response.result.value) as! [[String:AnyObject]])
                                UIApplication.sharedApplication().networkActivityIndicatorVisible = false
                            }
        })
    }
    class func getHTML(shortURL:String="",
                       parameters:[String:AnyObject]? = nil,
                       block:Bool = true,
                       complete:NSData -> Void) -> Request{
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        return Alamofire.request(.GET,
                          BaseURL+shortURL,
                          parameters: parameters,
                          headers: MOBILE_CLIENT_HEADERS)
            .responseData(queue: block ? nil : dispatch_get_global_queue(QOS_CLASS_BACKGROUND, 0),
                          completionHandler: { response in
                            complete(response.data!)
                            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
        })
    }

}
