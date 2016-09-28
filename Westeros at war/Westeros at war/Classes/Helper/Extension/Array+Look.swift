//
//  Array+Look.swift
//  Westeros at war
//
//  Created by Sachin on 11/09/16.
//  Copyright © 2016 sachin. All rights reserved.
//

import Foundation

//swift 2.0
extension Array {
    
    subscript (safe index: Int) -> Element? {
        return indices ~= index ? self[index] : nil
    }

}
