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
    @IBOutlet var progressBarLabel: UILabel!
    
    private var isBig = false
    
    var foodEntries = FoodEntryArrayWrapper(array: [
        FoodEntry(name: "Big mac", amountCal: 500),
        FoodEntry(name: "Banaan", amountCal: 90),
        FoodEntry(name: "Cola", amountCal: 140)
    ])
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // User large title in the navigationbar
        navigationController?.navigationBar.prefersLargeTitles = true
        
        progressTapped(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tabBarController?.tabBar.items?[0].badgeValue = String(foodEntries.array.count)
        
        progressBar.value = calculatePercent()
        progressBarLabel.text = String(totalCalories()) + " / 5000"
    }
    
    private func calculatePercent() -> CGFloat {
        return CGFloat((Double(totalCalories()) / 5000) * 100)
    }
    
    private func totalCalories() -> Int {
        return foodEntries.array.reduce(0) { $0 + $1.amountCal }
    }
    
    // Recognize tap gesture on the stackview
    @IBAction func progressTapped(_ sender: Any) {
        if !isBig {
            UIView.animate(withDuration: 0.5, animations: {
                self.progressBar.transform = CGAffineTransform.identity
                self.progressBarLabel.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.5) {
                self.progressBar.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
                self.progressBarLabel.alpha = 0.0
            }
        }
        
        isBig.toggle()
    }
    
    @IBAction func logButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "SegueLog", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueLog" {
            
        }
    }
}
