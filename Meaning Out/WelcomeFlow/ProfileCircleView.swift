//
//  ProfileImageView.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

import SnapKit

class ProfileCircleView: UIView {
    
    lazy var profileImageView = RoundView().then {
        $0.innerImageView.image = UIImage(resource: .profile0)
        $0.contentMode = .scaleAspectFill
        $0.layer.borderColor = UIColor(resource: .main).cgColor
        $0.layer.borderWidth = 5
    }
    
    lazy var cameraBadge = RoundView().then {
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 12, weight: .light)
        $0.innerImageView.image = UIImage(systemName: "camera.fill",withConfiguration: imageConfig)
        $0.innerImageView.contentMode = .center
        $0.tintColor = .white
        $0.backgroundColor = .main
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
        addSubview(profileImageView)
        addSubview(cameraBadge)
    }
    
    func configureLayout() {
        
        profileImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        cameraBadge.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(5)
            $0.bottom.equalToSuperview().inset(5)
            $0.width.equalTo(profileImageView.snp.width).multipliedBy(0.25)
            $0.height.equalTo(cameraBadge.snp.width)
        }
    }
}
