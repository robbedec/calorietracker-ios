//
//  SearchResultTableViewCell.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 05/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet var entryLabel: UIImageView!
    @IBOutlet var entryTitle: UILabel!
    @IBOutlet var entrySubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func update(with entry: FoodEntry, image: UIImage) {
        self.entryLabel.image = image
        self.entryTitle.text = entry.name
        self.entrySubTitle.text = "\(String(entry.amountCal)) calories"
    }
}
