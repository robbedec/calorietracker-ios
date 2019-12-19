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
    private var dailyIntake = 5000
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        progressTapped(self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
        setUpLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Don't forget to reset when view is being removed
        AppUtility.lockOrientation(.all)
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    private func setUpLabels() {
        tabBarController?.tabBar.items?[0].badgeValue = String(RealmController.instance.entries.count)
        
        progressBar.value = calculatePercent()
        
        guard totalCalories() < dailyIntake else {
            progressBarLabel.text = String(totalCalories()) + " / \(String(dailyIntake)) \n" + "Daily goal exceeded!"
            return
        }
        
        progressBarLabel.text = String(totalCalories()) + " / \(String(dailyIntake)) \n \(dailyIntake - totalCalories()) calories until daily goal"
    }
    
    private func calculatePercent() -> CGFloat {
        return CGFloat((Double(totalCalories()) / Double(dailyIntake)) * 100)
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
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "Clear", style: .destructive, handler: clearDatabaseConfirmed))
        
        
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
}
