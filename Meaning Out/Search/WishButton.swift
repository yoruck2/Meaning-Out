//
//  WishButton.swift
//  Meaning Out
//
//  Created by dopamint on 6/18/24.
//

import UIKit

import SnapKit
import Then

class WishButton: UIButton {
    
    var itemData: Item?
    var handler: (() -> Void)?
    
    var cellProductID: String
    let repository = WishListTableRepository.shared
    
    // TODO: 왜 didSet이 실행되는걸까??
    override var isSelected: Bool {
        didSet {
        }
    }
    
    init(cellProductID: String, isWished: Bool) {
        self.cellProductID = cellProductID
        super.init(frame: .zero)
        self.isSelected = isWished
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        
        backgroundColor = .white
        layer.cornerRadius = 5
        clipsToBounds = true
        
        contentMode = .center
        setImage(.likeUnselected, for: .normal)
        setImage(.likeSelected, for: .selected)
        
        addTarget(self, action: #selector(wishButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func wishButtonTapped() {
        self.isSelected.toggle()
        guard let itemData else {
            return
        }
        if self.isSelected == true {
            let data = WishlistTable(productId: cellProductID,
                                     title: itemData.title,
                                     link: itemData.link,
                                     image: itemData.image,
                                     price: itemData.lprice,
                                     mallName: itemData.mallName)
            repository.createItem(data, handler: nil)
            
            var tempList = UserDefaultsHelper.standard.wishList
            tempList.updateValue(true, forKey: cellProductID)
            UserDefaultsHelper.standard.wishList = tempList
        } else {
            if let existingItem = repository.findItem(productId: cellProductID) {
                repository.deleteItem(data: existingItem)
            }
            
            var tempList = UserDefaultsHelper.standard.wishList
            tempList.removeValue(forKey: cellProductID)
            UserDefaultsHelper.standard.wishList = tempList
        }
        handler?()
        NotificationCenter.default.post(name: NSNotification.Name("reloadCollectinView"),
                                        object: nil,
                                        userInfo: nil)
    }
}
