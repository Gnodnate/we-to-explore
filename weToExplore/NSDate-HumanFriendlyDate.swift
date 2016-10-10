//
//  String-HumanFriendlyDate.swift
//  weToExplore
//
//  Created by Daniel Tan on 8/24/16.
//  Copyright © 2016 Gnodnate. All rights reserved.
//

import Foundation

extension Date {
    /**
     Get Human Readable Date
     
     - author: Gnodnate
     
     - parameter timeInterval: time interval  from 1970
     
     - returns: Human readable date string
     */
    func humanReadableDate() -> String {
        let timePassed = Int(abs(self.timeIntervalSinceNow))
        switch timePassed {
        case let x where x < 60:
            return _L("one min ago")
        case let x where x < 60*60:
            return _L("\(x/60) mins ago")
        case let x where x < 60*60*24:
            return _L("\(x/60/60) hours ago")
        case let x where x < 60*60*24*365:
            return _L("\(x/60/60/24) hours ago")
        default:
            let formatter = DateFormatter()
            formatter.dateStyle = .medium
            formatter.timeStyle = .short
            return formatter.string(from: self)
        }
        
    }
}
