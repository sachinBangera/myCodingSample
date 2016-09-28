//
//  King.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import UIKit

class King {

    var name :String!
    var rating : Int! = 400
    var winCount : Int! = 0
    var lossCount : Int! = 0
    var attackcount : Int! = 0
    var defendcount : Int! = 0
    var imageName : String! = " "
    
    init(name : String ) {
        self.name = name
        self.imageName = self.getImage()
    }
    
    func getActionType() -> String {
        if self.attackcount > self.defendcount {
            return "Attacker"
        } else {
            return "Defender"
        }
    }
    
    func getActionTitle() -> String {
        if self.attackcount > self.defendcount {
            return "The Attacking Worrier"
        } else {
            return "The Defending Worrier"
        }
    }
    
    func getImage() -> String {
        let random = arc4random_uniform(4) + 1
        return "king" + String(random)
    }

}
