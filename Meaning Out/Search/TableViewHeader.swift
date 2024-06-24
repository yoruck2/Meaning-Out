//
//  tableViewHeader.swift
//  Meaning Out
//
//  Created by dopamint on 6/17/24.
//

import UIKit

import SnapKit
import Then

final class TableViewHeader: UIView, Configurable {
    
    let headerLabel = UILabel().then {
        $0.text = "최근 검색"
        $0.font = Font.bold16
    }
    
    lazy var clearAllButton = UIButton().then {
        $0.setTitle("전체 삭제", for: .normal)
        $0.setTitleColor(.main, for: .normal)
        $0.titleLabel?.font = Font.bold15
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierachy() {
        addSubview(headerLabel)
        addSubview(clearAllButton)
    }
    
    func configureLayout() {
        headerLabel.snp.makeConstraints {
            $0.leading.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
        }
        clearAllButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.height.equalToSuperview()
        }
    }
}

