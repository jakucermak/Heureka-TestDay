//
//  ViewController.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 05.10.2020.
//

import UIKit

class ViewController: UIViewController {

    var networkManager = NetworkManager()
    var selectedProduct: Product?
    var categoryFilter:[Int] = []
    
    @IBOutlet weak var productTable: UITableView!
    @IBOutlet weak var categoryCollection: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        networkManager.fetch(for: "categories", in: categoryCollection)
        networkManager.fetchProducts(for: "products", in: productTable)
        productTable.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "productCell")
        productTable.rowHeight = 80
        productTable.tableFooterView = UIView()
        categoryCollection.layer.borderColor = UIColor.black.cgColor
        categoryCollection.layer.borderWidth = 1
        categoryCollection.layer.cornerRadius = 15
    }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         if segue.identifier == "productDetailSegue",
            let detailViewController = segue.destination as? OffersDetailViewController{
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
        cell.configureCell(label: networkManager.categories[indexPath.item].title, imageName: networkManager
                            .categories[indexPath.item].categoryImageString)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
            let cell = categoryCollection.cellForItem(at: indexPath) as! CategoryViewCell
        cell.containerView.backgroundColor = cell.isSelected ? UIColor.systemBackground : UIColor(named: "LightBlue")
            cell.isSelected = !cell.isSelected
        if cell.isSelected{
            categoryFilter.append(networkManager.categories[indexPath.row].categoryId)
            productTable.reloadData()
        }else{
         categoryFilter.removeAll(where: {$0 == networkManager.categories[indexPath.row].categoryId})
            productTable.reloadData()
        }
           return false
        }
    }
    
//MARK: - UITableView DataSource
extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categoryFilter.count == 0{
        return networkManager.products.count
        }else{
           return filterProducts(products: networkManager.products).count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = productTable.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! ProductCell
        if categoryFilter.count == 0{
            cell.configureCell(Label: networkManager.products[indexPath.row].title, ID: networkManager.products[indexPath.row].categoryId)
            return cell
        }else{
            let filteredProducts = filterProducts(products: networkManager.products)
            cell.configureCell(Label: filteredProducts[indexPath.row].title, ID: filteredProducts[indexPath.row].categoryId)
            return cell
        }
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedProduct = networkManager.products[indexPath.row]
        performSegue(withIdentifier: "productDetailSegue", sender: self)
        tableView.deselectRow(at: indexPath, animated: false)
        
    }
    
    //MARK: - Filter Products
    func filterProducts(products: [Product])->[Product]{
        var filteredProducts: [Product] = []
        products
            .map{product in
                
                for i in categoryFilter{
                    if product.categoryId == i{
                        filteredProducts.append(product)
                    }
                }
            }
        return filteredProducts
    }
}
