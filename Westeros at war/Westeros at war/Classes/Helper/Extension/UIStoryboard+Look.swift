//
//  UIStoryboard+Look.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import UIKit


extension UIStoryboard
{
    class func get_ViewControllerFromStoryboard(storyBoardName : String, storyBoardIdentifier : String) -> AnyObject
    {
        let viewController:UIViewController = UIStoryboard(name: storyBoardName, bundle: nil).instantiateViewControllerWithIdentifier(storyBoardIdentifier)
        return viewController
    }
}


