//
//  SearchViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 30/11/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        NetworkController.singleton.fetchSearchResults(with: "cola") { results in
            guard let foodEntries = results else { return }
            for entry in foodEntries {
                print(entry.name)
                print(entry.amountCal)
            }
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
