//
//  ShoppingDTO.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import Foundation

struct Shopping: Codable {
    let lastBuildDate: String?
    let total, start, display: Int
    var items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice, mallName, productId: String
    let productType: String
}
