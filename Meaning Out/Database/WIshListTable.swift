//
//  WIshListTable.swift
//  Meaning Out
//
//  Created by dopamint on 7/8/24.
//

import Foundation
import RealmSwift

class WishlistTable: Object {
    @Persisted(primaryKey: true) var id: ObjectId
    @Persisted var productId: String
    @Persisted var title: String
    @Persisted var link: String
    @Persisted var image: String?
    @Persisted var price: String?
    @Persisted var mallName: String?
    
    convenience init(productId: String,
                     title: String,
                     link: String,
                     image: String,
                     price: String,
                     mallName: String) {
        self.init()
        self.productId = productId
        self.title = title
        self.link = link
        self.image = image
        self.price = price
        self.mallName = mallName
    }
}
