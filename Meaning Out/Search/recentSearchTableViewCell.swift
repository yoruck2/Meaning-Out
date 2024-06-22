//
//  SearchTableViewCell.swift
//  Meaning Out
//
//  Created by dopamint on 6/17/24.
//

import UIKit

import SnapKit
import Then

class recentSearchTableViewCell: UITableViewCell, Configurable {
    
    weak var delegate: recentSearchDelegate?
    var index: Int?
    
    let clockImageView = UIImageView().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold)
        $0.image = UIImage(systemName: "clock",withConfiguration: imageConfig)
        $0.contentMode = .center
        $0.tintColor = .black
    }
    
    lazy var productNameLabel = UILabel().then {
        $0.font = Font.bold15
    }
    
    lazy var deleteButton = UIButton().then {
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 15, weight: .bold)
        $0.setImage(UIImage(systemName: "xmark",withConfiguration: imageConfig), for: .normal)
        $0.contentMode = .center
        $0.tintColor = .darkerGray
        $0.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }

    @objc
    func deleteButtonTapped() {
        delegate?.removeRecentSearch(index: index ?? 0)
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureHierachy() {
        contentView.addSubview(clockImageView)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(deleteButton)
    }
    
    func configureLayout() {
        clockImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(5)
            $0.height.equalToSuperview()
            $0.width.equalTo(clockImageView.snp.height)
            $0.centerY.equalToSuperview()
        }
        
        productNameLabel.snp.makeConstraints {
            $0.leading.equalTo(clockImageView.snp.trailing).offset(6)
            $0.height.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.8)
            $0.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.trailing.equalToSuperview()
            $0.height.equalToSuperview()
            $0.width.equalTo(deleteButton.snp.height)
            $0.centerY.equalToSuperview()
        }
    }
}
