//
//  ProfileSettingViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

import SnapKit
import Then

class ProfileSettingViewController: MeaningOutViewController, Configurable {
    
    lazy var profileCircleView = ProfileCircleView().then {
        let tapImageViewRecognizer = UITapGestureRecognizer(target: self,
                                                            action: #selector(imageTapped))
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(tapImageViewRecognizer)
    }
    
    let nicknameTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        $0.leftView = paddingView
        $0.rightView = paddingView
        $0.leftViewMode = .always
        $0.rightViewMode = .always
        $0.placeholder = "닉네임을 입력해주세요 :)"
        $0.addBottomBorder(with: .lighterGray, width: 2)
    }
    
    let nicknameGuideLabel = UILabel().then {
        $0.text = "여기에 나옴"
        $0.textColor = .main
        $0.isHidden = true
    }
    
    lazy var completeButton = LargeCapsuleButton(style: .complete).then {
        $0.addTarget(self,
                     action: #selector(completeButtonTapped),
                     for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureLayout()
        configureUI()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.navigationBar.isHidden = false
    }
    
    func configureUI() {
        navigationItem.title = "PROFILE SETTING"
    }
    
    func configureHierachy() {
        view.addSubview(profileCircleView)
        view.addSubview(nicknameTextField)
        view.addSubview(nicknameGuideLabel)
        view.addSubview(completeButton)
    }
    
    func configureLayout() {
        profileCircleView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.3)
            $0.height.equalTo(profileCircleView.snp.width)
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.top.equalTo(profileCircleView.snp.bottom).offset(40)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
        nicknameGuideLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameTextField.snp.bottom).offset(10)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(30)
        }
        completeButton.snp.makeConstraints {
            $0.top.equalTo(nicknameGuideLabel.snp.bottom).offset(20)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.height.equalTo(50)
        }
    }
    
    @objc
    func completeButtonTapped() {

        let tabBar = MeaningOutTabBarController()
        tabBar.modalPresentationStyle = .fullScreen
        tabBar.modalTransitionStyle = .crossDissolve
        present(tabBar, animated: true) 
//        {
//            self.navigationController?.popToRootViewController(animated: false)
//       }
    }
    
    @objc 
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        navigationController?.pushViewController(ProfileImageSettingViewController(), animated: true)
        
    }
}

//extension ProfileSettingViewController: UITextFieldDelegate {
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        true
//    }
//
//}
