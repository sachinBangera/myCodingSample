//
//  NSDate+Look.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import Foundation

extension NSDate {
    
    func getDateStringFromDate() -> String{
        var dateFormatter:NSDateFormatter
        struct Static {
            static var instance: NSDateFormatter?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            let l_dateFormatter = NSDateFormatter()
            l_dateFormatter.dateFormat = "dd MMM"
            Static.instance = l_dateFormatter
        }
        dateFormatter = Static.instance!
        let stringDate = dateFormatter.stringFromDate(self)
        return stringDate
    }
    
}