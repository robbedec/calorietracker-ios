//
//  FoodEntry.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 30/11/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation

struct FoodEntry {
    var name: String
    var amountCal: Int
    var fromAPI: Bool
    
    init(name: String, amountCal: Int, fromAPI: Bool = false) {
        self.name = name
        self.amountCal = amountCal
        self.fromAPI = fromAPI
    }
}
