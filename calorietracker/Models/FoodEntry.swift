//
//  FoodEntry.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 30/11/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation
import RealmSwift

class FoodEntry: Object, Decodable {
    @objc dynamic var name: String = ""
    @objc dynamic var amountCal: Int = 0
    @objc dynamic var fromAPI: Bool = false
    @objc dynamic var dateAdded: Date?
    
    required init() {
        super.init()
    }
    
    required init(name: String, amountCal: Int, fromAPI: Bool = false) {
        super.init()
        self.name = name
        self.amountCal = amountCal
        self.fromAPI = fromAPI
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.amountCal = try Int(valueContainer.decode(Double.self, forKey: CodingKeys.amountCal))
        self.fromAPI = true
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "food_name"
        case amountCal = "nf_calories"
    }
}
