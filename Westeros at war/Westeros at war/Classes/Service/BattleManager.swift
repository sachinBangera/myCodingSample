//
//  BattleManager.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import UIKit
import Foundation
import ObjectMapper
import Alamofire
import AlamofireObjectMapper

let fetchBattleDetailsURL = "http://www.json-generator.com/api/json/get/bVnidDAqBe?indent=2" //"http://starlord.hackerearth.com:3478/gotjson"
let kFactor = 32.0

var highest : Int = 0
var lowest : Int = 0

class BattleManager : NSObject {
    
    var battleList = [Battle]()
    var kingsCollection = [String : King]()
    var kigsList = [King]()
    
    class var sharedManager: BattleManager{
        struct Static {
            static var instance: AnyObject?
            static var token: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.token) {
            let objectManager = BattleManager()
            Static.instance = objectManager
        }
        return Static.instance! as! BattleManager
    }
    
    override init() {
        super.init()
    }

    
    func getAllBattleDetails(complition : DownloadCompletion){
        ServiceManager.sharedManager.authorizedManager()?.request(.GET, fetchBattleDetailsURL).responseArray(keyPath: ""){
            [weak self](response: Response<[Battle], NSError>) in
            if let weakSelf = self {
                if response.result.error == nil {
                    if let battles = response.result.value {
                        weakSelf.battleList.appendContentsOf(battles)
                    }
                    
                    for battle in  weakSelf.battleList {
                        weakSelf.calculateTheKingsRatingsForBattle(battle)
                    }
                    NSNotificationCenter.defaultCenter().postNotificationName(Notification.downloadComplete, object: nil)
                    weakSelf.kigsList = Array(BattleManager.sharedManager.kingsCollection.values)
                    weakSelf.kigsList = weakSelf.kigsList.sort({ $0.rating > $1.rating })
                    
                    highest = (weakSelf.kigsList.first?.rating)!
                    lowest = (weakSelf.kigsList.last?.rating)!
                }
                complition(response: nil, sender: weakSelf, error: response.result.error)
            }
        }
    }
    
    
    
    func calculateTheKingsRatingsForBattle(battle : Battle) {
       
        var attacker: King!
        var defender: King!
        
        if let l_attacker =  self.kingsCollection[battle.attackerKing!] {
            attacker = l_attacker
            attacker.attackcount =  attacker.attackcount + 1 // created king already
        } else {
            let n_attcker = King(name: battle.attackerKing!)
            attacker = n_attcker
            attacker.attackcount = 1 // new King
        }

        if let l_defender =  kingsCollection[battle.defenderKing!] {
            defender = l_defender
            defender.defendcount = defender.defendcount + 1 //created king already
        } else {
            let n_defender = King(name: battle.defenderKing!)
            defender = n_defender
            defender.defendcount = 1   //new King
        }
        
        let r1 = Double(attacker.rating) / 400.0
        let r2 = Double(defender.rating) / 400.0
        
        let e1 = r1 / ( r1 + r2 )
        let e2 = r2 / ( r1 + r2 )
        
        
        var s1 = 0.5 // init with draw
        var s2 = 0.5 // init with draw
        
        if battle.attackerOutcome == BattleResult.win.rawValue {
            s1 = 1 // attacker won
            s2 = 0 // defender loss
            attacker.winCount =  attacker.winCount + 1
            defender.lossCount =  defender.lossCount + 1
        } else if battle.attackerOutcome == BattleResult.loss.rawValue {
            s1 = 0 // attacker loss
            s2 = 1 // defender won
            attacker.lossCount =  attacker.lossCount + 1
            defender.winCount =  defender.winCount + 1
        }
        
        attacker.rating = attacker.rating + Int(kFactor * (s1 - e1))
        defender.rating = defender.rating + Int(kFactor * (s2 - e2))
        
        self.kingsCollection[battle.attackerKing!] = attacker
        self.kingsCollection[battle.defenderKing!] = defender
        
    }
    

}


enum BattleResult : String {
    case win = "win"
    case loss = "loss"
    case draw = "draw"
}
