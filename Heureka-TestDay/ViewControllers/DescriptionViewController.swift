//
//  DescriptionViewController.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 06.10.2020.
//

import UIKit

class DescriptionViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var descriptionText: UITextView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    
    var selectedOffer: Offers?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.layer.cornerRadius = productImage.frame.width/2
        containerView.layer.cornerRadius = containerView.frame.width/2
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOpacity = 0.9
        containerView.layer.shadowRadius = 15
        containerView.layer.shadowOffset = CGSize(width: 5.0, height: 5.0)
        switch selectedOffer?.img_url != nil {
        case true:
            productImage.load(url: URL(string: (selectedOffer?.img_url)!)!)
        default:
            productImage.image = UIImage(systemName: "photo")
        }
        descriptionLabel.text = selectedOffer?.title
        descriptionText.text = selectedOffer?.description
            }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
