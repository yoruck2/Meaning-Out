//
//  settingMenuTableViewCell.swift
//  Meaning Out
//
//  Created by dopamint on 6/18/24.
//

import UIKit

import SnapKit
import Then

class SettingMenuTableViewCell: UITableViewCell, Configurable {
    
    let menuLabel = UILabel().then {
        $0.font = Font.medium16
    }
    
    var cartListCountLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func makeCartListCountLabel(cartCount: Int) {
        let attributedString = NSMutableAttributedString()
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(resource: .likeSelected)
        imageAttachment.bounds = CGRect(x: 0, y: -5, width: 22, height: 22)
        attributedString.append(NSAttributedString(attachment: imageAttachment))
        attributedString.append(NSAttributedString(string: " \(cartCount)개의 상품"))
        attributedString.addAttribute(.font, value: Font.bold16, range: NSRange(location: 0, length: 4))
        cartListCountLabel.attributedText = attributedString
    }
    
    func configureHierachy() {
        contentView.addSubview(menuLabel)
        contentView.addSubview(cartListCountLabel)
    }
    
    func configureLayout() {
        menuLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
        }
        cartListCountLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(10)
        }
    }
}
