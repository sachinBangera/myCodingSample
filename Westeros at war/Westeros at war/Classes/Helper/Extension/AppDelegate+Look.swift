//
//  AppDelegate+Look.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//
import UIKit

extension AppDelegate
{
    class func getRootViewController() -> UINavigationController {
        
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        let viewController = appDelegate.window!.rootViewController as! UINavigationController
        return viewController
    }
    
    class func getAppDelegate() -> AppDelegate {
        
        let appDelegate  = UIApplication.sharedApplication().delegate as! AppDelegate
        return appDelegate
    }
    
}