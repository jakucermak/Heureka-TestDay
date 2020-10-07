//
//  CategoryViewCell.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 05.10.2020.
//

import UIKit

class CategoryViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var containerView: UIView!
    

    func configureCell(label: String, imageName: String) {
        
        containerView.layer.cornerRadius = 15
        containerView.layer.shadowColor = UIColor.darkGray.cgColor
        containerView.layer.shadowOffset = CGSize(width: 1.0, height: 1.0)
        containerView.layer.shadowOpacity = 0.9
        containerView.layer.shadowRadius = 15
        
        categoryImage.image = UIImage(systemName: imageName)
        categoryImage.layer.cornerRadius = 15
        categoryImage.clipsToBounds = true
        categoryImage.layer.borderWidth = 2
        categoryImage.layer.borderColor = UIColor.gray.cgColor
        categoryImage.tintColor = UIColor.white
        categoryLabel.text = label
        
    }
}
