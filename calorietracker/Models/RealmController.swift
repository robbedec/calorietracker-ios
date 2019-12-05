//
//  RealmController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 05/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation
import RealmSwift
import UIKit

class RealmController {
    static let instance: RealmController = RealmController()
    
    var entries: Results<FoodEntry> = try! Realm().objects(FoodEntry.self)
    //var realmUpdatables: Array<RealmUpdatable> = []
    
    func newEntry(entry: FoodEntry, completion: @escaping(Error?) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                entry.dateAdded = Date()
                realm.add(entry)
            }
            
        } catch let error as NSError {
            completion(error)
            return
        }
        completion(nil)
    }
}
