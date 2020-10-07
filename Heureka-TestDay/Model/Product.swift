//
//  Product.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 06.10.2020.
//

import Foundation

struct Product: Codable {
    var categoryId: Int
    var productId: Int
    var title: String
    
    
    var categoryImageString: String{
        switch categoryId{
        case 1: return "iphone"
        case 2: return "leaf"
        case 3: return "guitars"
        default: return "questionmark"
        }
    }
    
}
