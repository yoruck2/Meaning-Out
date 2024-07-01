//
//  ProfileSettingViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

import SnapKit
import Then

enum NicknameGuide: String {
    case validNickname = "사용할 수 있는 닉네임이에요"
    case invalidCount = "2글자 이상 10글자 미만으로 설정 해주세요"
    case containedSpecialCharacter = "닉네임에 @, #, $, % 는 포함할 수 없어요"
    case containedNumber = "닉네임에 숫자는 포함할 수 없어요"
}

class ProfileSettingViewController: MeaningOutViewController, Configurable {
    
    lazy var profileCircleView = ProfileCircleView().then {
        if UserDefaultsHelper.standard.nickname.isEmpty {
            let imageNumber = Int.random(in: 0...11)
            $0.profileImageView.innerImageView.image = UIImage(named: "profile_\(imageNumber)")
        } else {
            $0.profileImageView.innerImageView.image = UserDefaultsHelper.standard.profileImage
        }
        let tapImageViewRecognizer = UITapGestureRecognizer(target: self,
                                                            action: #selector(imageTapped))
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(tapImageViewRecognizer)
    }
    
    @objc
    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        
        let nextVC = ProfileImageSettingViewController()
        
        nextVC.profileCircleView.profileImageView.innerImageView.image = self.profileCircleView.profileImageView.innerImageView.image
        nextVC.delegate = self
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    lazy var nicknameTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
        $0.leftView = paddingView
        $0.rightView = paddingView
        $0.leftViewMode = .always
        $0.rightViewMode = .always
        $0.placeholder = "닉네임을 입력해주세요 :)"
        $0.addBottomBorder(with: .lighterGray, width: 2)
        
        $0.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    let nicknameGuideLabel = UILabel().then {
        $0.text = ""
        $0.font = Font.bold13
        $0.textColor = .main
    }
    
    lazy var completeButton = LargeCapsuleButton(style: .complete).then {
        
        $0.isEnabled = false
        $0.addTarget(self,
                     action: #selector(completionButtonTapped),
                     for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHierachy()
        configureLayout()
        configureUI()
    }
    
    @objc
    override func backbuttonTapped() {
        let imageNumber = Int.random(in: 0...11)
        profileCircleView.profileImageView.innerImageView.image = UIImage(named: "profile_\(imageNumber)")
        nicknameTextField.text = ""
        self.navigationController?.popViewController(animated: true)
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
    func completionButtonTapped() {
        guard let nickname = nicknameTextField.text,
              let profileImage = profileCircleView.profileImageView.innerImageView.image
        else {
            return
        }
        UserDefaultsHelper.standard.nickname = nickname
        UserDefaultsHelper.standard.profileImage = profileImage
        UserDefaultsHelper.standard.signUpDate = Date.todayString()
        
        let tabBar = MeaningOutTabBarController()
//        tabBar.modalPresentationStyle = .fullScreen
//        tabBar.modalTransitionStyle = .crossDissolve
//        present(tabBar, animated: true)
        
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let sceneDelegate = windowScene?.delegate as? SceneDelegate
        sceneDelegate?.window?.rootViewController = tabBar
        sceneDelegate?.window?.makeKeyAndVisible()
    }
    
    @objc
    func textFieldDidChange(_ textField: UITextField) {
        
        guard let text = textField.text else {
            return
        }
        
        let validation = validateNickName(text)
        if validation == .validNickname {
            completeButton.isEnabled = true
            nicknameGuideLabel.text = validation.rawValue
        } else {
            completeButton.isEnabled = false
            nicknameGuideLabel.text = validation.rawValue
        }
    }
    
    // TODO: 에러 핸들링 적용해볼려 했는데 여러 케이스별로 나뉘는거라.. 안되는건가??
    func validateNickName(_ text: String) -> NicknameGuide {
        
        let filteredText = text.components(separatedBy: ["#","$","@","%"]).joined()
        guard filteredText == text else {
            return .containedSpecialCharacter
        }
        
        let filteredNumber = text.filter { $0.isNumber }
        guard filteredNumber.isEmpty else {
            return .containedNumber
        }
        
        guard 2..<10 ~= text.count else {
            return .invalidCount
        }
        
        return .validNickname
    }
}

extension ProfileSettingViewController: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension ProfileSettingViewController: ProfileImageSettingDelegate {
    func didSelectProfileImage(_ image: UIImage) {
        profileCircleView.profileImageView.innerImageView.image = image
    }
}
