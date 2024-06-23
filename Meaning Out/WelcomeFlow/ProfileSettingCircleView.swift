//
//  profileSettingCircleView.swift
//  Meaning Out
//
//  Created by dopamint on 6/16/24.
//

import UIKit

import SnapKit
import Then

class ProfileSettingCircleView: UIImageView {
    
    override var isHighlighted: Bool {
        didSet {
            if isHighlighted {
                layer.borderColor = UIColor(resource: .main).cgColor
                layer.borderWidth = 3
                alpha = 1
            } else {
                layer.borderColor = UIColor(resource: .lighterGray).cgColor
                layer.borderWidth = 1
                alpha = 0.5
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        layer.borderColor = UIColor(resource: .lighterGray).cgColor
        layer.borderWidth = 1
        alpha = 0.5
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = self.bounds.width / 2
        clipsToBounds = true
        
    }
}

