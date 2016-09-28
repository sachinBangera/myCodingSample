//
//  Constants.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//


import Foundation
import UIKit

typealias DownloadCompletion = (response: AnyObject?, sender: AnyObject, error: NSError?)-> Void
typealias BlockResponder = (response: AnyObject?, sender: AnyObject?)-> Void
typealias CompletionBlock = (response: AnyObject?, sender: AnyObject?)-> Void


struct Storyboard {
    
    static let main = "Main"
}

struct Notification {
    
    struct Network {
        
        static let statusChanged = "statusChangedNotification"
    }
    
        static let downloadComplete = "downloadCompleteNotification"
}


enum ViewAlignType : Int
{
    case AlignCenter = 0
    case AlignLeft = 1
    case AlignRight = 2
}