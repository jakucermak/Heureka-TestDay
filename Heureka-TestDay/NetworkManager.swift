//
//  NetworkManager.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 06.10.2020.
//

import Foundation
import UIKit


class NetworkManager {
    var categories:[Category] = [Category]()
    var products:[Product] = [Product]()
    var offers:[Offers] = [Offers]()
    
    var baseUrl = "https://heureka-testday.herokuapp.com/"
    func fetch(for urlSuffix: String, in collectionView: UICollectionView ){
        let url: URL? = URL(string: "\(baseUrl)\(urlSuffix)")
        if let safeURL = url {
            URLSession.shared.dataTask(with: safeURL) { (data, response, error) in
                if error == nil{
                    if let safeData = data {
                        do {
                          let decodedData = try JSONDecoder().decode([Category].self, from: safeData)
                            DispatchQueue.main.async {
                                self.categories = decodedData
                                collectionView.reloadData()
                            }
                        } catch  {
                            print("error while decoding Data:\(error.localizedDescription)")
                        }
                    }
                }
            }.resume()
        }else{
            print("invalid URL")
        }
}
    func fetchProducts(for urlSuffix: String, in tableView: UITableView){
        let url: URL? = URL(string: "\(baseUrl)\(urlSuffix)")
        if let safeUrl = url{
            URLSession.shared.dataTask(with: safeUrl) { (data, response, error) in
                if error == nil{
                    if let safeData = data{
                            do {
                                let decodedData = try JSONDecoder().decode([Product].self, from: safeData)
                                DispatchQueue.main.async {
                                    self.products = decodedData
                                    tableView.reloadData()
                                }
                            } catch {
                                print("error while decoding Data:\(error.localizedDescription)")
                            }
                        }
                }else{
                    print("error:",error?.localizedDescription)
                }
            }.resume()
        }else{
            print("invalid URL")
        }
    }
    
    func fetchOffers(for urlSuffx: String, in tableView: UITableView){
        let url: URL? = URL(string: "\(baseUrl)\(urlSuffx)")
        if let safeUrl = url{
            URLSession.shared.dataTask(with: safeUrl) { (data, response, error) in
                if error == nil{
                    if let safeData = data{
                        do {
                            let decodedData = try JSONDecoder().decode([Offers].self, from: safeData)
                            DispatchQueue.main.async {
                                self.offers = decodedData
                                tableView.reloadData()
                            }
                        } catch {
                            print("error while decoding data")
                        }
                    }
                }else{
                    print("error:",error?.localizedDescription)
                }
            }.resume()
        }else{
            print("ivalid URL")
        }
    }
    
}
