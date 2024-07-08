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
    
    var handler: (() -> Void)?
    
    var cellProductID: String
    let repository = WishListTableRepository.shared
    
    override var isSelected: Bool {
        didSet {
            if self.isSelected == true {
                print(UserDefaultsHelper.standard.wishList)
                print(cellProductID)
                
                
                var tempList = UserDefaultsHelper.standard.wishList
                tempList.updateValue(true, forKey: cellProductID)
                UserDefaultsHelper.standard.wishList = tempList
            } else {
                print(UserDefaultsHelper.standard.wishList)
                print(cellProductID)
                
                var tempList = UserDefaultsHelper.standard.wishList
                tempList.removeValue(forKey: cellProductID)
                UserDefaultsHelper.standard.wishList = tempList
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
        
    }
}
