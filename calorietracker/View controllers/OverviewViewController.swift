//
//  ViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 06/10/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit

class OverviewViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        

    }
    
    @IBAction func logButtonClicked(_ sender: Any) {
        performSegue(withIdentifier: "SegueLog", sender: nil)
    }
}

