//
//  WEDataManager.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/19/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import UIKit
import Alamofire

open class WEDataManager: NSObject {
    fileprivate static let shareManager = WEDataManager()
    private static let BaseURL = "https://www.v2ex.com/"
    private static let USER_AGENT = "Mozilla/5.0 (iPhone; CPU iPhone OS 9_0 like Mac OS X) AppleWebKit/600.1.3 (KHTML, like Gecko) Version/8.0 Mobile/12A4345d Safari/600.1.4"
    private static let MOBILE_CLIENT_HEADERS = ["user-agent" : USER_AGENT]

    fileprivate override init() {
        super.init()
    }
    class func getJSON(_ shortURL:String="",
                 parameters:[String:Any]? = nil,
                 block:Bool = false,
                 complete:@escaping ([[String:AnyObject]]) -> Void) -> Request {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return Alamofire.request(BaseURL+shortURL,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: MOBILE_CLIENT_HEADERS)
            .responseJSON(completionHandler: { (response) in
                if response.result.isSuccess {
                    complete((response.result.value) as! [[String:AnyObject]])
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            })
    }
    class func getHTML(_ shortURL:String="",
                       parameters:[String:Any]? = nil,
                       block:Bool = true,
                       complete:@escaping (NSData) -> Void) -> Request{
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        return Alamofire.request(BaseURL+shortURL,
                                 method: .get,
                                 parameters: parameters,
                                 encoding: URLEncoding.default,
                                 headers: MOBILE_CLIENT_HEADERS)
            .responseData(completionHandler: { (response) in
                complete(response.data! as NSData)
                UIApplication.shared.isNetworkActivityIndicatorVisible = false

            })
    }

}
