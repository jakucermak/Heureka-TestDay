//
//  Offers.swift
//  Heureka-TestDay
//
//  Created by Jakub Čermák on 06.10.2020.
//

import Foundation
struct Offers: Codable {
    var description: String?
    var img_url: String?
    var offerId: Int
    var price: Int
    var productId: Int
    var title: String
    var url: String
}
