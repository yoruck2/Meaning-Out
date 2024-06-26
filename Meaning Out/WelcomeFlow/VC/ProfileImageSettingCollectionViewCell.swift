//
//  profileImageSelectionCollectionViewCell.swift
//  Meaning Out
//
//  Created by dopamint on 6/15/24.
//

import UIKit

import SnapKit
import Then

class ProfileImageSettingCollectionViewCell: UICollectionViewCell, Configurable {

    var profileImageView = ProfileSettingCircleView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierachy() {
        contentView.addSubview(profileImageView)
    }
    
    func configureLayout() {
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}


