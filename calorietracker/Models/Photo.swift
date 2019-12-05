//
//  Photo.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 05/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation
import RealmSwift

class Photo: Object, Decodable {
    
    @objc var thumb: String = ""
    //@objc var highRes: String = ""
    
    required init() {
        super.init()
    }
    
    required init(from decoder: Decoder) throws {
        let valueContainer = try decoder.container(keyedBy: CodingKeys.self)
        
        self.thumb = try valueContainer.decode(String.self, forKey: CodingKeys.thumb)
        //self.highRes = try valueContainer.decode(String.self, forKey: CodingKeys.highRes)
    }
    
    private enum CodingKeys: String, CodingKey {
        case thumb = "thumb"
        case highRes = "highres"
    }
}
