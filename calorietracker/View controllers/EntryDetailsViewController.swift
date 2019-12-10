//
//  EntryDetailsViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 05/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit

class EntryDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var entryName: UILabel!
    @IBOutlet var entryCompany: UILabel!
    @IBOutlet var entryWeight: UILabel!
    @IBOutlet var entryNutrients: UITableView!
    
    var foodEntry: FoodEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        entryName.text = "\(foodEntry.name) (\(String(foodEntry.amountCal)) calories)"
        entryCompany.text = foodEntry.brandName
        
        if let servingValue = foodEntry.weight.value {
            entryWeight.text = "Serving weight is \(String(servingValue)) grams"
        } else {
            entryWeight.text = "No available serving weight"
        }
        
        
        
        self.entryNutrients.dataSource = self
        self.entryNutrients.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodEntry.nutrients.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = entryNutrients.dequeueReusableCell(withIdentifier: "NutrientCell", for: indexPath)
        
        let nutrient = self.foodEntry.nutrients[indexPath.row]
        
        cell.textLabel?.text = "\(String(nutrient.value.value!)) \(nutrient.unit) \(nutrient.name)"
        return cell
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
