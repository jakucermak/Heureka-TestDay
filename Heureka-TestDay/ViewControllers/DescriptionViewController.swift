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
        productImage.load(url: URL(string: "https://im9.cz/iR/importprodukt-orig/58f/58f0e6512d7f1563354e2fbb9568f2b8.jpg")!)
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
extension UIImageView{
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url){
                if let image = UIImage(data: data){
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
