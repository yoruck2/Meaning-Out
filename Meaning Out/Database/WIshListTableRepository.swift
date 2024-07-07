//
//  WIshListTableRepository.swift
//  Meaning Out
//
//  Created by dopamint on 7/8/24.
//

import Foundation
import RealmSwift

class WishListTableRepository {
    
    static let shared = WishListTableRepository()
    private init() {
        print(realm.configuration.fileURL ?? "")
    }
    
    let realm = try! Realm()
    lazy var wishlistTable = realm.objects(WishlistTable.self)
    
    // MARK: CUD -
    func createItem(_ data: WishlistTable, handler: (() -> Void)?) {
        do {
            try realm.write {
                realm.add(data, update: .modified)
                handler?()
            }
        } catch {
            print("데이터 불러오기 실패")
        }
    }
    //    func  updateItem(_ data: WishlistTable, handler: (() -> Void)) {
    //        try! realm.write {
    //            realm.add(data)
    //            handler()
    //        }
    //    }
    func deleteItem(data: WishlistTable) {
        try! realm.write {
            realm.delete(data)
        }
    }
}
