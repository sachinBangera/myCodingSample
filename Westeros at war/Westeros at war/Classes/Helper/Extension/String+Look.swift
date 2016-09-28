//
//  String+Look.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import Foundation

extension String {
    
    var absoluteImagePath : String {
        get {
            let array = self.characters.split {$0 == "/"}.map(String.init)
            if let url = array.last {
                return url
            } else {
                return ""
            }
        }
    }
    
    var absoluteBase64String : String {
        get {
            if let range = self.rangeOfString("data:image/png;base64,", options: .AnchoredSearch)  {
                return self.stringByReplacingCharactersInRange(range, withString: "")
            } else {
                return self
            }
        }
    }
    
    
    func displayStringfromApiDate() -> String? {
        var dateFormatter:NSDateFormatter
        
        struct Static {
            static var instance: NSDateFormatter?
            static var token: dispatch_once_t = 0
        }
        dispatch_once(&Static.token) {
            let l_dateFormatter = NSDateFormatter()
            l_dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
            Static.instance = l_dateFormatter
        }
        dateFormatter = Static.instance!
        if let date = dateFormatter.dateFromString(self) {
            return date.getDateStringFromDate()
        } else {
            return nil
        }
    }
    

}

extension Int {
    

    
}