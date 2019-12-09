//
//  EntryDetailsViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 05/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit

class EntryDetailsViewController: UIViewController {

    @IBOutlet var entryName: UILabel!
    @IBOutlet var entryCompany: UILabel!
    
    
    var foodEntry: FoodEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        entryName.text = foodEntry.name
        entryCompany.text = foodEntry.brandName
        
        print(foodEntry.name)
        print(foodEntry.weight.value)
        print(foodEntry.nutrients.count)
        
        for nut in foodEntry.nutrients {
            print(nut.name)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
