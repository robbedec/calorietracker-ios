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
    var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        AppUtility.lockOrientation(.all)
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
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
            
            self.timer?.invalidate()
            self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SearchTableViewController.showResults), userInfo: searchText, repeats: false)
            
            guard !searchText.isEmpty else {
                self.timer.invalidate()
                self.items.removeAll()
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
                self.tableView.reloadData()
                return
            }
            
            self.showSpinner()
        }
    }
    
    @objc func showResults() {
        guard let searchText = timer.userInfo as? String else { return }
        
        NetworkController.instance.fetchSearchResults(with: searchText) { results in
            guard let foodEntries = results else { return }
            
            self.items = foodEntries
            
            DispatchQueue.main.async {
                self.timer.invalidate()
                self.removeSpinner()
                self.tableView.reloadData()
                
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
                    self.removeSpinner()
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
}
