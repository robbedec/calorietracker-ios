//
//  ApiWrapper.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 02/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation

struct ApiWrapper: Decodable {
    var branded: [FoodEntry]
    
    enum CodingKeys: String, CodingKey {
        case branded
    }
    
    init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.branded = try valueContainer.decode([FoodEntry].self, forKey: CodingKeys.branded)
    }
}
