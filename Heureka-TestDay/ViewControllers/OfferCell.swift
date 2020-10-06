//
//  OfferCell.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 06.10.2020.
//

import UIKit

class OfferCell: UITableViewCell {

    @IBOutlet weak var offerImage: UIImageView?
    @IBOutlet weak var shopName: UILabel!
    @IBOutlet weak var prize: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    
}
