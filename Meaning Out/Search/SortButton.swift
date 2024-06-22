//
//  filterButton.swift
//  Meaning Out
//
//  Created by dopamint on 6/18/24.
//

import UIKit

import SnapKit
import Then

class SortButton: UIButton {
    
    override var isSelected: Bool {
        didSet {
            if isSelected == true {
                backgroundColor = .darkerGray
                tintColor = .white
            } else {
                backgroundColor = .white
                tintColor = .darkerGray
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(resource: .darkerGray).cgColor
        tintColor = .black
    }
}
