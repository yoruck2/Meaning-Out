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
    
    var imageNumber = 0
    var profileImageView = ProfileSettingCircleView(frame: .zero)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierachy()
        configureLayout()
        configureUI()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        print(imageNumber)
        profileImageView.image = UIImage(named: "profile_" + "\(imageNumber)")
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


