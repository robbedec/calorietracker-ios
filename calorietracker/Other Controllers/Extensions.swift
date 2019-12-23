//
//  Extensions.swift
//  calorietracker
//
//  Created by ROBBE DECORTE on 02/12/2019.
//  Copyright © 2019 ROBBE DECORTE. All rights reserved.
//

import Foundation
import UIKit

// SOURCE: https://stackoverflow.com/a/45157417
extension UITableView {
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont(name: "TrebuchetMS", size: 15)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

/*
 Display and remove an acitivity indicator on a viewcontroller
 
 SOURCE: https://www.youtube.com/watch?v=twgb5IPwR4I
 */
fileprivate var indicatorView: UIView!

extension UIViewController {
    func showSpinner() {
        self.removeSpinner()
        indicatorView = UIView(frame: self.view.bounds)
        indicatorView?.backgroundColor = UIColor.init(red: 0.8, green: 0.8, blue: 0.8, alpha: 0.9)
        
        let ai = UIActivityIndicatorView(style: .whiteLarge)
        ai.center = view!.center
        ai.startAnimating()
        
        indicatorView?.addSubview(ai)
        self.view.addSubview(indicatorView!)
        
        Timer.scheduledTimer(withTimeInterval: 15, repeats: false) { (t) in
            self.removeSpinner()
        }
    }
    
    func removeSpinner() {
        indicatorView?.removeFromSuperview()
        indicatorView = nil
    }
}
