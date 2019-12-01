//
//  NetworkController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 01/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation

class NetworkController {
    static let singleton: NetworkController = NetworkController()
    
    let baseUrl: URL = URL(string: "https://trackapi.nutritionix.com/v2/")!
    
    func fetchSearchResults(completion: @escaping (_ foodEntries: [FoodEntry]?) -> Void) {
        
    }
}
