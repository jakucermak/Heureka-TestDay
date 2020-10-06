//
//  ViewController.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 05.10.2020.
//

import UIKit

class ViewController: UIViewController {

    var categories = ["Mobilní telefony","Hudební nástroje", "Ostatní"]
    var products:[String] = ["iPhone X", "iPhone Xs", "iPhone Xr Max"]
    
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        productTable.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "productCell")
        productTable.rowHeight = 80
        productTable.tableFooterView = UIView()
    }


}
//MARK: - UICollection DataSource
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 80.0, height: 80.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = categoryCollection.dequeueReusableCell(withReuseIdentifier: "categoryCell", for: indexPath) as! CategoryViewCell
        cell.sizeToFit()
        cell.configureCell(label: categories[indexPath.item], imageName: "iphone")
        return cell
    }
    
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        cell.configureCell(Label: products[indexPath.row], Image: "iphone")
        return cell
    }
    
    
}
