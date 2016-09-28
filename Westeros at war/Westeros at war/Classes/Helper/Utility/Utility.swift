//
//  Utility.swift
//
//  Created by Sachin
//

import UIKit

let imageSource = "imageSource"

class Utility: NSObject {
    

    class func getMeRated(rating : Int) -> String {
        var value = (rating * 5) / highest
        if value <= 0 {
            value = 1
        }
        return value.description
    }

    class  func parentController(parentController:UIViewController, withContainer containerView:UIView, withChildController childController:UIViewController, withFrameWidth width:NSInteger, align:ViewAlignType) {
        parentController.addChildViewController(childController)
        let frame = containerView.bounds;
        childController.view.frame = frame
        containerView.addSubview(childController.view)
        childController.didMoveToParentViewController(parentController);
        let childView:UIView = childController.view;
        
        let parentView:UIView = containerView;
        
        childView.translatesAutoresizingMaskIntoConstraints = false
        parentView.translatesAutoresizingMaskIntoConstraints = false
        
        let labelssDictionary =  ["childView":childView,"parentView":parentView]
        
        var c1:[NSLayoutConstraint]?
        switch (align.rawValue)
        {
        case ViewAlignType.AlignCenter.rawValue :
            c1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[childView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: labelssDictionary)
            break
        case ViewAlignType.AlignLeft.rawValue :
            c1 = NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[childView(\(width))]", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: labelssDictionary)
            break
        case ViewAlignType.AlignRight.rawValue :
            c1 = NSLayoutConstraint.constraintsWithVisualFormat("H:[childView(\(width))]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: labelssDictionary)
            break
        default :
            c1 = nil
            
        }
        let c2 = NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[childView]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: labelssDictionary)
        
        parentView.addConstraints(c1!)
        parentView.addConstraints(c2);
    }
    
    class func removeChildController(childController: UIViewController,fromParentController parentController: UIViewController, fromContainerView containerView: UIView) -> Void {
        childController.willMoveToParentViewController(nil)
        let containerConstraints: Array =  containerView.constraints
        unowned let childView: UIView = childController.view
        let l_predicate: NSPredicate = NSPredicate { (evaluatedObject, bindings) -> Bool in
            return evaluatedObject.firstItem === childView
        }
        let l_constraints: Array = containerConstraints.filter { l_predicate.evaluateWithObject($0) }
        containerView.removeConstraints(l_constraints)
        childView.removeFromSuperview()
        childController.removeFromParentViewController()
    }
    
    class func displayAlertWith(controller:UIViewController,title:String,message:String,leftTitle:String?,rightTitle:String?,completionHandler: ((UIAlertAction!)->Void)!) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.Alert)
        if leftTitle != nil {
            let leftAction = UIAlertAction(title: leftTitle!, style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
                if completionHandler != nil {
                    completionHandler(alert)
                }
            })
            alert.addAction(leftAction)
        }
        
        if rightTitle != nil {
            let rightAction = UIAlertAction(title: rightTitle!, style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
                if completionHandler != nil {
                    completionHandler(alert)
                }
            })
            alert.addAction(rightAction)
        }
        controller.presentViewController(alert, animated: true, completion: nil)
        return alert
    }
    
    class func displayAlertWithThreeButton (controller:UIViewController,title:String,message:String,leftTitle:String?,middleTitle:String?,rightTitle:String?,completionHandler: ((UIAlertAction!)->Void)!) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.Alert)
        if leftTitle != nil {
            let leftAction = UIAlertAction(title: leftTitle!, style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
                if completionHandler != nil {
                    completionHandler(alert)
                }
            })
            alert.addAction(leftAction)
        }
        if middleTitle != nil {
            let  middleAction = UIAlertAction(title: middleTitle!, style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
                if completionHandler != nil {
                    completionHandler(alert)
                }
            })
            alert.addAction(middleAction)
            
        }
        
        if rightTitle != nil {
            let rightAction = UIAlertAction(title: rightTitle!, style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
                if completionHandler != nil {
                    completionHandler(alert)
                }
            })
            alert.addAction(rightAction)
        }
        controller.presentViewController(alert, animated: true, completion: nil)
        return alert
    }
    
    class func createAlertWith(title:String,message:String,leftTitle:String?,rightTitle:String?,completionHandler: ((UIAlertAction!)->Void)!) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle:UIAlertControllerStyle.Alert)
        if leftTitle != nil {
            let leftAction = UIAlertAction(title: leftTitle!, style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
                if completionHandler != nil {
                    completionHandler(alert)
                }
            })
            alert.addAction(leftAction)
        }
        
        if rightTitle != nil {
            let rightAction = UIAlertAction(title: rightTitle!, style: UIAlertActionStyle.Default, handler: { (alert:UIAlertAction!) -> Void in
                if completionHandler != nil {
                    completionHandler(alert)
                }
            })
            alert.addAction(rightAction)
        }
        return alert
    }
}