//
//  FoodEntry.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 30/11/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation

struct FoodEntry: Codable {
    var name: String
    var amountCal: Int
    var fromAPI: Bool
    
    init(name: String, amountCal: Int, fromAPI: Bool = false) {
        self.name = name
        self.amountCal = amountCal
        self.fromAPI = fromAPI
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.amountCal = try Int(valueContainer.decode(Double.self, forKey: CodingKeys.amountCal))
        self.fromAPI = true
    }
    
    enum CodingKeys: String, CodingKey {
        case name = "food_name"
        case amountCal = "nf_calories"
    }
}
