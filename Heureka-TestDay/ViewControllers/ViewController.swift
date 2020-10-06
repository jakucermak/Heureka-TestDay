//
//  ViewController.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 05.10.2020.
//

import UIKit

class ViewController: UIViewController {

    var networkManager = NetworkManager()
    
    var products:[String] = ["iPhone X", "iPhone Xs", "iPhone Xr Max"]
    var selectedProduct: String?
    
    
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkManager.fetch(for: "categories", in: categoryCollection)
        productTable.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "productCell")
        productTable.rowHeight = 80
        productTable.tableFooterView = UIView()
        categoryCollection.reloadData()
        
    }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "productDetailSegue",
            let detailViewController = segue.destination as? ProductDetailViewController{
            detailViewController.selectedProduct = selectedProduct
         }
     }
}
//MARK: - UICollection DataSource
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80.0, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return networkManager.categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryViewCell
        cell.sizeToFit()
        cell.configureCell(label: networkManager.categories[indexPath.item].title, imageName: "iphone")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
            let cell = categoryCollection.cellForItem(at: indexPath) as! CategoryViewCell
            cell.containerView.backgroundColor = cell.isSelected ? UIColor.systemBackground : UIColor.systemBlue
            cell.isSelected = !cell.isSelected
           return false
        }
    }
    
//MARK: - UITableView DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.configureCell(Label: products[indexPath.row], Image: "iphone")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = self.products[indexPath.row]
        
        performSegue(withIdentifier: "productDetailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
    }
}
