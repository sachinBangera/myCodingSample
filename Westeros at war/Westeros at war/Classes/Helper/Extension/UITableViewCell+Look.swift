//
//  UITableViewCell+Look.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import UIKit

extension UITableViewCell
{
    public class var identifier : String {
        var name = NSStringFromClass(self)
        name = name.componentsSeparatedByString(".").last!
        return name
    }
    
    public class var height : CGFloat {
        return CGFloat(54.0)
    }
    
}