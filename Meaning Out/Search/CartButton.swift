//
//  CartButton.swift
//  Meaning Out
//
//  Created by dopamint on 6/18/24.
//

import UIKit

import SnapKit
import Then

class CartButton: UIButton {
    
    var cellProductID: String
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected == true {
                print(UserDefaultsHelper.standard.cartList)
                print(cellProductID)
                var tempList = UserDefaultsHelper.standard.cartList
                tempList.updateValue(true, forKey: cellProductID)
                UserDefaultsHelper.standard.cartList = tempList

            } else {
                print(UserDefaultsHelper.standard.cartList)
                print(cellProductID)
                var tempList = UserDefaultsHelper.standard.cartList
                tempList.removeValue(forKey: cellProductID)
                UserDefaultsHelper.standard.cartList = tempList
            }
        }
    }
    
    init(cellProductID: String) {
        self.cellProductID = cellProductID
        super.init(frame: .zero)
        configureUI()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        
        backgroundColor = .white
        layer.cornerRadius = 5
        clipsToBounds = true
        
        contentMode = .center
        setImage(.likeUnselected, for: .normal)
        setImage(.likeSelected, for: .selected)
        
        addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func cartButtonTapped() {
        self.isSelected.toggle()
    }
}
