//
//  ProductCell.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 06.10.2020.
//

import UIKit

class ProductCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(Label: String, Image: String)  {
        productLabel.text = Label
        productImage.image = UIImage(systemName: Image)
    }
    
}
