//
//  UIImage+Look.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

extension UIImage {
    
    class func imageWithView(view: UIView) -> UIImage {
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, 0.0)
        view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img
    }
  
    var grayScaleImage : UIImage? {
        get {
            defer{
                UIGraphicsEndImageContext()
            }
            let imageRect = CGRectMake(0, 0, self.size.width, self.size.height);
            let colorSpace = CGColorSpaceCreateDeviceGray();
            
            let width = Int(self.size.width)
            let height = Int(self.size.height)
            let context = CGBitmapContextCreate(nil, width, height, 8, 0, colorSpace, .allZeros);
            CGContextDrawImage(context, imageRect, self.CGImage!);
            if let imageRef = CGBitmapContextCreateImage(context) {
                let newImage = UIImage(CGImage: imageRef)
                CGContextClearRect(context, imageRect)
                return newImage
            } else {
                return self
            }
        }
    }
    
    class var placeHolderImageRoundedCorner: UIImage{
        struct Static {
            static var instance: AnyObject?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            let object = UIImage(named: "place_holder_rounded_corner")
            Static.instance = object
        }
        return Static.instance! as! UIImage
    }
    
    class var placeHolderImage: UIImage{
        struct Static {
            static var instance: AnyObject?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            let object = UIImage(named: "place_holder")
            Static.instance = object
        }
        return Static.instance! as! UIImage
    }
    
    class var placeHolderUserImageRounded: UIImage{
        struct Static {
            static var instance: AnyObject?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            let object = UIImage(named: "place_holder_rounded_user_profile")
            Static.instance = object
        }
        return Static.instance! as! UIImage
    }
    
    class var placeHolderUserImage: UIImage{
        struct Static {
            static var instance: AnyObject?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            let object = UIImage(named: "place_holder_user_profile")
            Static.instance = object
        }
        return Static.instance! as! UIImage
    }
    
    class var greyplaceHolderGreyImage: UIImage{
        struct Static {
            static var instance: AnyObject?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            let object = UIImage(named: "place_holder")?.grayScaleImage
            Static.instance = object
        }
        return Static.instance! as! UIImage
    }
    
    
    
}

