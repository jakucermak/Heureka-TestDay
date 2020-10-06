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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.layer.cornerRadius = productImage.frame.width/2
        containerView.layer.cornerRadius = containerView.frame.width/2
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
