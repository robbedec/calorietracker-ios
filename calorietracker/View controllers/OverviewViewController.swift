//
//  ViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 06/10/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    var foodEntries = FoodEntryArrayWrapper(array: [
        FoodEntry(name: "Big mac", amountCal: 500),
        FoodEntry(name: "Banaan", amountCal: 90),
        FoodEntry(name: "Cola", amountCal: 140)
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tabBarController?.tabBar.items?[0].badgeValue = String(foodEntries.array.count)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.items?[0].badgeValue = String(foodEntries.array.count)
    }
    
    @IBAction func logButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "SegueLog", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueLog" {
            let tableController = segue.destination as! LogTableViewController
            tableController.foodEntries = self.foodEntries
        }
    }
}
