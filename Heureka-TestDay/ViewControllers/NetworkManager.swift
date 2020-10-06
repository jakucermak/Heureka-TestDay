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
    func fetch(for urlSuffix: String, in collectionView: UICollectionView){
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
                                print("collectioReloaded")
                                for i in self.categories{
                                    print(i.title)
                                }
                                
                            }
                        } catch  {
                            print("error while decoding Data")
                            fatalError(error.localizedDescription)
                        }
                    }
                }
            }.resume()
        }else{
            print("invalid URL")
        }
}
}
