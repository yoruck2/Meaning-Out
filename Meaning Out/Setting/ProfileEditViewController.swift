//
//  ProfileEditViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/18/24.
//

import UIKit

import SnapKit
import Then

class ProfileEditViewController: ProfileSettingViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        completeButton.isHidden = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장",
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(saveButtonTapped))
    }
    
    @objc
    func saveButtonTapped() {
        if NicknameGuide.validNickname == viewModel.outputValidationText.value {
            UserDefaultsHelper.standard.nickname = nicknameTextField.text ?? ""
            UserDefaultsHelper.standard.profileImage = profileCircleView.profileImageView.innerImageView.image ?? UIImage()
            self.navigationController?.popViewController(animated: true)
        } else {
            nicknameGuideLabel.text = "저장 안됨!!!"
        }
    }
}
//@objc
//func saveButtonTapped() {
//    do {
//        if try NicknameErrorGuide.validNickname == validateNickName(nicknameTextField.text ?? "") {
//            UserDefaultsHelper.standard.nickname = nicknameTextField.text ?? ""
//            UserDefaultsHelper.standard.profileImage = profileCircleView.profileImageView.innerImageView.image ?? UIImage()
//            self.navigationController?.popViewController(animated: true)
//        }
//    } catch {
//            nicknameGuideLabel.text = "저장 안됨!!!"
//    }
//}
//}
