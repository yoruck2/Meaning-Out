//
//  filterButton.swift
//  Meaning Out
//
//  Created by dopamint on 6/18/24.
//

import UIKit

import SnapKit
import Then

enum SortPriority: String, CaseIterable {
    case accuracy = "정확도"
    case recentDate = "날짜순"
    case higherPrice = "가격높은순"
    case lowerPrice = "가격낮은순"
    
    var parameterValue: String {
        switch self {
        case .accuracy:
            return "sim"
        case .recentDate:
            return "date"
        case .higherPrice:
            return "dsc"
        case .lowerPrice:
            return "asc"
        }
    }
}

class SortButton: UIButton {
    var sortingMethod: SortPriority
    
    override var isSelected: Bool {
        didSet {
            backgroundColor = isSelected ? .darkerGray : .white
        }
    }
    
    init(_ sortingPriority: SortPriority) {
        sortingMethod = sortingPriority
        super.init(frame: .zero)
        configureUI()
        
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        setTitle(sortingMethod.rawValue, for: .normal)
        setTitleColor(.darkerGray, for: .normal)
        setTitleColor(.white, for: .selected)
        backgroundColor = .white
        
        layer.cornerRadius = 20
        clipsToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor(resource: .darkerGray).cgColor
        
        addTarget(self, action: #selector(sortButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func sortButtonTapped() {
        self.isSelected.toggle()
    }
}
