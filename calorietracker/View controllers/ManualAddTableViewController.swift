//
//  ManualAddTableViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 30/11/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit

class ManualAddTableViewController: UITableViewController {

    @IBOutlet var saveButton: UIBarButtonItem!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var amountTextField: UITextField!
    
    
    var foodEntry: FoodEntry!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        updateSaveButtonState()
    }
    
    private func updateSaveButtonState() {
        let nameText = nameTextField.text ?? ""
        let amountText = amountTextField.text ?? ""
        
        saveButton.isEnabled = !nameText.isEmpty && !amountText.isEmpty
    }
    
    @IBAction func textEditingChanged(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        // Do nothing when cancel is pressed
        guard segue.identifier == "SegueManualSave" else { return }
        
        let nameText = nameTextField.text ?? ""
        let amountText = amountTextField.text ?? ""
        
        foodEntry = FoodEntry(name: nameText, amountCal: Int(amountText) ?? 0)
    }
}
