//
//  ProfileAreaView.swift
//  Meaning Out
//
//  Created by dopamint on 6/17/24.
//

import UIKit

import SnapKit
import Then

class ProfileAreaView: UIView, Configurable {
    
    lazy var profileCircleView = ProfileSettingCircleView(frame: .zero).then {
        $0.isHighlighted = true
    }
    
    let nicknameLabel = UILabel().then {
        $0.font = Font.bold16
    }
    let signUpDate = UILabel().then {
        $0.font = Font.bold13
        $0.textColor = .mediumGray
    }
    let indicator = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.forward")
        $0.tintColor = .darkerGray
    }
    
    let settingMenuTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func configureHierachy() {
        addSubview(profileCircleView)
        addSubview(nicknameLabel)
        addSubview(signUpDate)
        addSubview(indicator)
        addSubview(settingMenuTableView)
    }
    
    func configureLayout() {
        profileCircleView.snp.makeConstraints {
//            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(30)
            $0.width.equalTo(profileCircleView.snp.height)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.
        }
        
        signUpDate.snp.makeConstraints {
            $0.
        }
        
        indicator.snp.makeConstraints {
            $0.
        }
        
        settingMenuTableView.snp.makeConstraints {
            $0.
        }
        
        
        
    }
    
    
}
