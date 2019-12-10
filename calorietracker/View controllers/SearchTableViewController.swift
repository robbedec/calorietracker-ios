//
//  SearchTableViewController.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 01/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit

class SearchTableViewController: UITableViewController, UISearchResultsUpdating {

    var items: [FoodEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func setupNavBar() {
        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        self.definesPresentationContext = true
        
        navigationItem.searchController = searchController
        
        // Never hide the searchbar
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    
    func updateSearchResults(for searchController: UISearchController) {
        if let searchText = searchController.searchBar.text {
            
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            
            guard !searchText.isEmpty else {
                self.items.removeAll()
                self.tableView.reloadData()
                return
            }
            self.showSpinner()
            NetworkController.instance.fetchSearchResults(with: searchText) { results in
                guard let foodEntries = results else { return }
                
                self.items = foodEntries
                
                DispatchQueue.main.async {
                    self.removeSpinner()
                    self.tableView.reloadData()
                    
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if items.count == 0 {
            self.tableView.setEmptyMessage("No results")
        } else {
            self.tableView.restore()
        }
        
        return items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchCell", for: indexPath) as! SearchResultTableViewCell
        
        // Configure the cell...
        let foodEntry = items[indexPath.row]
        
        if let icon = foodEntry.image?.thumb {
            let image = URL(string: icon)!
            NetworkController.instance.fetchImage(with: image) { image in
                guard let image = image else { return }
                DispatchQueue.main.async {
                    cell.update(with: foodEntry, image: image)
                }
            }
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let foodEntry = items[indexPath.row]
        
        NetworkController.instance.fetchNutrientInformation() { results in
            guard let results = results else { return }
            
            for nutrient in foodEntry.nutrients {
                let obj = results.first(where: { $0.id == nutrient.id })
                
                if let obj = obj {
                    nutrient.name = obj.name
                    nutrient.unit = obj.unit
                }
            }
          
            DispatchQueue.main.async {
                RealmController.instance.newEntry(entry: foodEntry){ error in
                    if let error = error {
                        print(error)
                    } else {
                        self.tabBarController?.selectedIndex = 0
                        self.tabBarController?.tabBar.items?[0].badgeValue = String(RealmController.instance.entries.count)
                    }
                }
            }
         }
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
