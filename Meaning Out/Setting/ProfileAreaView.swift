//
//  ProfileAreaView.swift
//  Meaning Out
//
//  Created by dopamint on 6/17/24.
//

import UIKit

import SnapKit
import Then

final class ProfileAreaView: UIView, Configurable {
    
    lazy var profileCircleView = ProfileSettingCircleView(frame: .zero).then {
        $0.image = UserDefaultsHelper.standard.profileImage
        $0.isHighlighted = true
    }
    
    let nicknameLabel = UILabel().then {
        $0.text = UserDefaultsHelper.standard.nickname
        $0.font = Font.bold16
    }
    let signUpDate = UILabel().then {
        $0.text = UserDefaultsHelper.standard.signUpDate + " 가입"
        $0.font = Font.bold13
        $0.textColor = .mediumGray
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [nicknameLabel, signUpDate]).then {
        $0.axis = .vertical
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 4
    }
    
    let indicator = UIImageView().then {
        $0.image = UIImage(systemName: "chevron.forward")
        $0.tintColor = .darkerGray
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
        addSubview(profileCircleView)
        addSubview(stackView)
        addSubview(indicator)
    }
    
    func configureLayout() {
        profileCircleView.snp.makeConstraints {
            $0.leading.equalToSuperview().inset(10)
            $0.verticalEdges.equalToSuperview().inset(15)
            $0.width.equalTo(profileCircleView.snp.height)
        }
        
        stackView.snp.makeConstraints {
            $0.leading.equalTo(profileCircleView.snp.trailing).offset(20)
            $0.centerY.equalToSuperview()
        }
        indicator.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(10)
            $0.centerY.equalToSuperview()
        }
    }
}
