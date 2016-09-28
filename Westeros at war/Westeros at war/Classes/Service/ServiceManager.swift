//
//  ServiceManager.swift
//  FHKiosk
//
//  Created by Sachin on 12/04/16.
//  Copyright © 2016 uirevolution. All rights reserved.
//

import Foundation
import Alamofire
import SystemConfiguration

class ServiceManager: NSObject {
    
    var authManager: Manager!
    var reachability : Reachability!
    var networkAlert : UIAlertController?
    
    class var sharedManager: ServiceManager{
        struct Static {
            static var instance: AnyObject?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            let objectManager = ServiceManager()
            Static.instance = objectManager
        }
        return Static.instance! as! ServiceManager
    }
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self,selector: #selector(ServiceManager.networkReachabilityRegistration(_:)),name: UIApplicationDidBecomeActiveNotification ,object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self,selector: #selector(ServiceManager.networkReachabilityDeregistration(_:)),name: UIApplicationWillResignActiveNotification ,object: nil)
    }
    
    
    func authorizedManager()-> Manager? {
        if authManager == nil {
            let configuration = Manager.sharedInstance.session.configuration
            configuration.HTTPAdditionalHeaders = authHeader()
            authManager = Alamofire.Manager(configuration: configuration)
            
        }
        return authManager
    }
    
    func authHeader() -> [String:String]? {
        return ["Content-Type" : "application/json; charset=UTF-8", "Accept-Encoding" : "gzip, deflate", "Accept" : "application/json; charset=UTF-8" ]
    }
    
    //MARK: Network Rechability - Registration
    
    func networkReachabilityRegistration(notification: NSNotification){
        
        reachability = Reachability.reachabilityForInternetConnection()
        
        if !reachability!.isReachable(){
            networkUnreachableAction()
        }
        
        reachability!.whenReachable = { reachability in
            if reachability.isReachableViaWiFi() {
                self.networkReachableAction()
            } else {
                self.networkReachableAction()
            }
        }
        reachability!.whenUnreachable = { reachability in
            self.networkUnreachableAction()
        }
        reachability!.startNotifier()
    }
    
    //MARK: Network Rechability - Deregistration

    func networkReachabilityDeregistration(notification: NSNotification){
        let reachability = Reachability.reachabilityForInternetConnection()
        reachability!.stopNotifier()
    }
    
    
    //MARK: Network Rechability - network Reachable Action
    
    func networkReachableAction(){
        print("network available")
        let cntrl = AppDelegate.getRootViewController()
        if (networkAlert == nil) {
            self.networkAlert = Utility.createAlertWith("", message: "Network is available you can now continue to use the application", leftTitle: "Cancel", rightTitle: "Retry", completionHandler: {
                [weak self](alertAction :UIAlertAction!) -> Void in
                if let weakSelf = self {
                    if alertAction.title == "Retry" {
                        NSNotificationCenter.defaultCenter().postNotificationName(Notification.Network.statusChanged, object: nil)
                    }
                  weakSelf.networkAlert = nil
                }
            })
            networkAlert?.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            if let _ = cntrl.presentedViewController {
                self.networkAlert = nil // Avoid presenting an alert + overlapp mutlu]i alert
            } else {
                cntrl.presentViewController(networkAlert!, animated: true, completion: nil)
            }
        }
    }
    
    //MARK: Network Rechability - network Unreachable Action
    
    func networkUnreachableAction(){
        print("no network available")
        let cntrl = AppDelegate.getRootViewController()
        if (networkAlert == nil) {
            
            self.networkAlert = Utility.createAlertWith("", message: "A connection error has occurred. \nTry again later", leftTitle: "Cancel", rightTitle: "Retry", completionHandler: {
                [weak self](alertAction :UIAlertAction!) -> Void in
                if let weakSelf = self {
                    if alertAction.title == "Retry" {
                        NSNotificationCenter.defaultCenter().postNotificationName(Notification.Network.statusChanged, object: nil)
                    }
                  weakSelf.networkAlert = nil
                }
            })
            networkAlert?.modalPresentationStyle = UIModalPresentationStyle.OverCurrentContext
            if let _ = cntrl.presentedViewController {
                self.networkAlert = nil // Avoid presenting an alert + overlapp mutlu]i alert
            } else {
                cntrl.presentViewController(networkAlert!, animated: true, completion: nil)
            }
        }
    }
}