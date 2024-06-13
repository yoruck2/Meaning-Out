//
//  ShoppingDTO.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import Foundation

struct ShoppingDTO: Codable {
    let lastBuildDate: String?
    let total, start, display: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title: String
    let link: String
    let image: String
    let lprice, hprice, mallName, productID: String
    let productType: String
//    let brand, maker: Brand
//    let category1: Category1
//    let category2: Category2
//    let category3: Category3
//    let category4: String

    enum CodingKeys: String, CodingKey {
        case title, link, image, lprice, hprice, mallName
        case productID = "productId"
        case productType
    }
}
