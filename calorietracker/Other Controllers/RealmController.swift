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
    
    var entries: Results<FoodEntry> = try! Realm().objects(FoodEntry.self).filter("dateAdded BETWEEN %@", [Calendar.current.startOfDay(for: Date()), {
                let components = DateComponents(day: 1, second: -1)
                return Calendar.current.date(byAdding: components, to: Date())!
            }()
        ]
    ).sorted(byKeyPath: "dateAdded", ascending: false)
    
    func newEntry(entry: FoodEntry, completion: @escaping(Error?) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                entry.id = (realm.objects(FoodEntry.self).map{$0.id}.max() ?? 0) + 1
                entry.dateAdded = Date()
                realm.add(entry)
            }
            
        } catch let error as NSError {
            completion(error)
            return
        }
        completion(nil)
    }
    
    func removeEntry(entry: FoodEntry, completion: @escaping(Error?) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.delete(entry)
            }
        } catch let error as NSError {
            completion(error)
            return
        }
        completion(nil)
    }
    
    func clearDatabase(completion: @escaping(Error?) -> Void) {
        do {
            let realm = try Realm()
            try realm.write {
                realm.deleteAll()
            }
        } catch let error as NSError {
            completion(error)
            return
        }
        completion(nil)
    }
}
