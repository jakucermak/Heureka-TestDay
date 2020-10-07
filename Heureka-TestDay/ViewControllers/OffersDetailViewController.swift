//
//  ProductDetailViewController.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 06.10.2020.
//

import UIKit

class OffersDetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var offerTableView: UITableView!
    var selectedProduct: Product?
    var selectedOffer: Offers?
    let networkManager = NetworkManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        productImage.image = UIImage(systemName: selectedProduct!.categoryImageString)
        productLabel.text = selectedProduct?.title
        offerTableView.register(UINib(nibName: "OfferCell", bundle: nil), forCellReuseIdentifier: "offerCell")
        offerTableView.rowHeight = 138
        offerTableView.tableFooterView = UIView()
        networkManager.fetchOffers(for: "offers/\((selectedProduct?.productId)!)", in: offerTableView)
        // Do any additional setup after loading the view.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDescription" , let descriptionViewController = segue.destination as? DescriptionViewController{
           descriptionViewController.selectedOffer = selectedOffer
        }
}
}

extension OffersDetailViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return networkManager.offers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = offerTableView.dequeueReusableCell(withIdentifier: "offerCell", for: indexPath) as! OfferCell
        cell.prize.text = "\(networkManager.offers[indexPath.row].price),-"
        cell.shopName.text = networkManager.offers[indexPath.row].title
        if let url = networkManager.offers[indexPath.row].img_url{
            cell.offerImage?.load(url: URL(string: url)! )
        }else{
            switch selectedProduct?.categoryId {
            case 1:  cell.offerImage?.image = UIImage(systemName: "iphone")
            case 2:  cell.offerImage?.image = UIImage(systemName: "leaf")
            case 3:  cell.offerImage?.image = UIImage(systemName: "guitars")
            default:  cell.offerImage?.image = UIImage(systemName: "questionmark")
        }
        }
        
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "Co pro Vás mohu udělat?", message: "", preferredStyle: .actionSheet)
        let descriptionBtn = UIAlertAction(title: "Zobrazit popis", style: .default) { (action) in
            self.selectedOffer = self.networkManager.offers[indexPath.row]
            self.performSegue(withIdentifier: "showDescription", sender: self)
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let openUrl = UIAlertAction(title: "Otevřít URL", style: .default) { (openURL) in
                let link = URL(string: self.networkManager.offers[indexPath.row].url)
                    UIApplication.shared.open(link!)
            
            tableView.deselectRow(at: indexPath, animated: true)
        }
        let cancell = UIAlertAction(title: "Zrušit", style: .cancel)
        if networkManager.offers[indexPath.row].description != nil {
            alert.addAction(descriptionBtn)
        }
       
        alert.addAction(openUrl)
        alert.addAction(cancell)
        
        present(alert, animated: true)
    }
    
    
}

//MARK: - load UIImageView from URL extension

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

