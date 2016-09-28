//
//  Battle.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import UIKit
import ObjectMapper

class Battle: BaseModel {

    var year : Int?
    var defenderKing : String?
    var location : String?
    var battleNumber : Int?
    var attackerKing : String?
    var battleType : String?
    var nameOfBattle : String?
    var region : String?
    var attackerOutcome : String?

    override func mapping(map: Map) {
        super.mapping(map)
        self.year <- map["year"]
        self.defenderKing <- map["defender_king"]
        self.location <- map["location"]
        self.battleNumber <- map["battle_number"]
        self.attackerKing <- map["attacker_king"]
        self.battleType <- map["battle_type"]
        self.nameOfBattle <- map["name"]
        self.region <- map["region"]
        self.attackerOutcome <- map["attacker_outcome"]
    }
}

