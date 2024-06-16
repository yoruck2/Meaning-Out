//
//  ProfileImageView.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

class ProfileCircleView: RoundView {

    let profileImageView = UIImageView().then {
        $0.image = UIImage(resource: .profile0)
        $0.contentMode = .scaleAspectFill
    }
    
    let cameraBadge = UIImageView().then {
        $0.image = UIImage(systemName: "camera.fill")
        $0.tintColor = .white
        $0.backgroundColor = .main
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        self.layer.borderColor = UIColor(resource: .main).cgColor
        self.layer.borderWidth = 3
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
}
