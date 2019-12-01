//
//  ViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 06/10/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit
import UICircularProgressRing

class OverviewViewController: UIViewController {

    @IBOutlet var progressBar: UICircularProgressRing!
    
    var foodEntries = FoodEntryArrayWrapper(array: [
        FoodEntry(name: "Big mac", amountCal: 500),
        FoodEntry(name: "Banaan", amountCal: 90),
        FoodEntry(name: "Cola", amountCal: 140)
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.items?[0].badgeValue = String(foodEntries.array.count)
        
        progressBar.value = calculatePercent()
    }
    
    private func calculatePercent() -> CGFloat {
        var result = 0
        for entry in foodEntries.array {
            result += entry.amountCal
        }
        print(result)
        return CGFloat((Double(result) / 5000) * 100)
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
