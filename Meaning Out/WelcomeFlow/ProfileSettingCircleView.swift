//
//  profileSettingCircleView.swift
//  Meaning Out
//
//  Created by dopamint on 6/16/24.
//

import UIKit

import SnapKit
import Then

//protocol ProfileDelegate: AnyObject {
//    func transfer(data: UIImage)
//}

class ProfileSettingCircleView: UIImageView {
    
    override var isHighlighted: Bool {
        
        
        didSet {
            print("isHighlighted 바낌")
            if isHighlighted {
                print("회색으로")
                //                delegate?.transfer(data: image ?? UIImage())
                layer.borderColor = UIColor(resource: .lighterGray).cgColor
                layer.borderWidth = 1
                alpha = 0.5
            } else {
                print("하이라이트")
                layer.borderColor = UIColor(resource: .main).cgColor
                layer.borderWidth = 3
                alpha = 1
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
//        image = UIImage(resource: .profile1)
        layer.borderColor = UIColor(resource: .main).cgColor
        layer.borderWidth = 3
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        layer.cornerRadius = self.bounds.width / 2
        clipsToBounds = true
        
    }
}

