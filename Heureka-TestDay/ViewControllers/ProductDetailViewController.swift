//
//  ProductDetailViewController.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 06.10.2020.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var offerTableView: UITableView!
    var selectedProduct: String?
    
    var offers:[String] = ["hello", "World"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productLabel.text = selectedProduct
        offerTableView.register(UINib(nibName: "OfferCell", bundle: nil), forCellReuseIdentifier: "offerCell")
        offerTableView.rowHeight = 138
       // offerTableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
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

extension ProductDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = offerTableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as! OfferCell
        cell.prize.text = "123456"
        cell.shopName.text = "Alza.cz"
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Co pro Vás mohu udělat?", message: "", preferredStyle: .actionSheet)
        let descriptionBtn = UIAlertAction(title: "Zobrazit popis", style: .default) { (action) in
            self.performSegue(withIdentifier: "showDescription", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let openUrl = UIAlertAction(title: "Otevřít URL", style: .default) { (openURL) in
            let link = URL(string: "https://www.google.com")
            UIApplication.shared.open(link!)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        alert.addAction(descriptionBtn)
        alert.addAction(openUrl)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}
