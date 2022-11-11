//
//  UICollectionView+Extensions.swift
//  SquareTakeHome
//
//  Created by Alex Vickers on 11/11/22.
//

import UIKit

extension UICollectionView {
    /// Displays a message on the background of a collection view, useful for displaying error states
    /// - Parameter message: the message to display to users
    func setBackgroundView(withMessage message: String) {
        let label = UILabel()
        label.text = message
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.sizeToFit()
        
        self.backgroundView = label
    }
    
    func clearBackground() {
        self.backgroundView = nil
    }
}
