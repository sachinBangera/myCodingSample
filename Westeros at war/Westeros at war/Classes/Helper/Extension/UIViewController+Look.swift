//
//  UIViewController+Look.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
   
    public class var identifier : String {
        var name = NSStringFromClass(self)
        name = name.componentsSeparatedByString(".").last!
        return name
    }
    
    public var isVisible : Bool{
        get {
            if self.view.window != nil {
                return true
            } else {
                return false
            }
        }
    }
    
    func setupProgressHud () {
        let hud = SVProgressHUD.appearance()
        hud.defaultStyle = .Custom
        hud.foregroundColor = UIColor.whiteColor()
        hud.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
        hud.defaultMaskType = .Clear
    }
    
    public func showHUD() {
       self.setupProgressHud()
        guard SVProgressHUD.isVisible() == false && self.isVisible == true else {
            return
        }
        SVProgressHUD.show()
    }
    
    public func hideHUD() {
        SVProgressHUD.dismiss()
    }
    
}



