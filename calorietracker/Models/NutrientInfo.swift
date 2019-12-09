//
//  NutrientInfo.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 09/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation

struct NutrientInfo: Decodable {
    var id: Int
    var name: String
    var unit: String
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        self.name = try valueContainer.decode(String.self, forKey: CodingKeys.name)
        self.unit = try valueContainer.decode(String.self, forKey: CodingKeys.unit)
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "attr_id"
        case name = "usda_nutr_desc"
        case unit
    }
}
