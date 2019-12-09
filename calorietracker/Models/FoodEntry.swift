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
    
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var amountCal: Int = 0
    @objc dynamic var fromAPI: Bool = false
    @objc dynamic var dateAdded: Date?
    @objc dynamic var brandName: String = ""
    @objc dynamic var image: Photo?
    var nutrients = List<AbstractNutrient>()
    
    var weight: RealmOptional<Double> = RealmOptional<Double>()
    
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
        self.brandName = try valueContainer.decode(String.self, forKey: CodingKeys.brandName)
        self.image = try valueContainer.decode(Photo.self, forKey: CodingKeys.photo)
        
        self.fromAPI = true
        
        let weight = try valueContainer.decodeIfPresent(Double.self, forKey: CodingKeys.weight)
        
        if let weight = weight {
            self.weight.value = weight
        }
        
        self.nutrients.append(objectsIn: try valueContainer.decode([AbstractNutrient].self, forKey: CodingKeys.nutrients))
    }
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    private enum CodingKeys: String, CodingKey {
        case name = "food_name"
        case amountCal = "nf_calories"
        case brandName = "brand_name"
        case weight = "serving_weight_grams"
        case photo
        case nutrients = "full_nutrients"
    }
}
