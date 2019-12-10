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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressTapped(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setUpLabels()
    }
    
    private func setUpLabels() {
        tabBarController?.tabBar.items?[0].badgeValue = String(RealmController.instance.entries.count)
        
        progressBar.value = calculatePercent()
        progressBarLabel.text = String(totalCalories()) + " / 5000"
    }
    
    private func calculatePercent() -> CGFloat {
        return CGFloat((Double(totalCalories()) / 5000) * 100)
    }
    
    private func totalCalories() -> Int {
        return RealmController.instance.entries.reduce(0) { $0 + $1.amountCal }
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
    
    
    @IBAction func clearButtonClicked(_ sender: Any) {
        let alert = UIAlertController(title: "Clear entries", message: "Are you sure that you want to delete your current data?", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .destructive, handler: nil))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: clearDatabaseConfirmed))
        
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    private func clearDatabaseConfirmed(alert: UIAlertAction) {
        RealmController.instance.clearDatabase() { error in
            if let error = error {
                print(error)
            } else {
                self.setUpLabels()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SegueLog" {
            
        }
    }
}
