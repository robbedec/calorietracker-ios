//
//  LogTableViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 30/11/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit
import RealmSwift

class LogTableViewController: UITableViewController {

    var entries: Results<FoodEntry>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        entries = RealmController.instance.entries
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return entries.count
        } else {
            return 0
        }
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EntryCell", for: indexPath)
        
        // Configure the cell...
        let foodEntry = entries[indexPath.row]
        
        cell.textLabel?.text = "\(foodEntry.name)"
        cell.detailTextLabel?.text = "\(foodEntry.amountCal) calories"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodEntry = entries[indexPath.row]
        
        guard foodEntry.fromAPI else {
            // Show an alert if the user clicks a manually added entry
            let alert = UIAlertController(title: "Entry detail", message: "Product details are not available for manually added entries.", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
            return
        }
        performSegue(withIdentifier: "SegueDetail", sender: nil)
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let foodEntry = entries[indexPath.row]
            RealmController.instance.removeEntry(entry: foodEntry) { error in
                if let error = error {
                    print(error)
                } else {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                    self.tabBarController?.tabBar.items?[0].badgeValue = String(RealmController.instance.entries.count)
                }
            }
        } 
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "SegueDetail" {
            let path = self.tableView.indexPathForSelectedRow!
            let viewController = segue.destination as! EntryDetailsViewController
            
            viewController.foodEntry = self.entries![path.row]
        }
    }
    
    @IBAction func unwindToLogTableView(segue: UIStoryboardSegue) {
        guard segue.identifier == "SegueManualSave",
            let sourceViewController = segue.source as? ManualAddTableViewController,
            let newEntry = sourceViewController.foodEntry else { return }
        
        let newIndexPath = IndexPath(row: 0, section: 0)

        RealmController.instance.newEntry(entry: newEntry) { error in
            if let error = error {
                print(error)
            } else {
                self.tableView.insertRows(at: [newIndexPath], with: .automatic)
                self.tabBarController?.tabBar.items?[0].badgeValue = String(RealmController.instance.entries.count)
            }
        }
        
    }
}
