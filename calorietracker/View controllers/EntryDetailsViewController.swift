//
//  EntryDetailsViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 05/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit

class EntryDetailsViewController: UIViewController {

    var foodEntry: FoodEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        print(foodEntry.name)
        print(foodEntry.weight.value)
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
