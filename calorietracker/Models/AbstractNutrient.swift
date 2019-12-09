//
//  AbstractNutrient.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 09/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation
import RealmSwift

class AbstractNutrient: Object, Decodable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var unit: String = ""
    var value: RealmOptional<Double> = RealmOptional<Double>()
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        super.init()
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try valueContainer.decode(Int.self, forKey: CodingKeys.id)
        
        let amount = try valueContainer.decodeIfPresent(Double.self, forKey: CodingKeys.value)
        
        if let amount = amount {
            self.value.value = amount
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case id = "attr_id"
        case value
    }
}
