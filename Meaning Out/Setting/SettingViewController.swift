//
//  SettingViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/16/24.
//

import UIKit

import SnapKit
import Then

class SettingViewController: MeaningOutViewController, Configurable {
    
    
    
    
    
//    @objc
//    func imageTapped(tapGestureRecognizer: UITapGestureRecognizer) {
//        
//        let nextVC = ProfileImageSettingViewController()
//        
//        nextVC.profileCircleView.profileImageView.innerImageView.image = profileCircleView.image
//        nextVC.delegate = self
//        navigationController?.pushViewController(nextVC, animated: true)
//    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    func configureUI() {
        navigationItem.title = "SETTING"
    }
    func configureHierachy() {
         
    }
    
    func configureLayout() {
         
    }
    
}

extension SettingViewController: ProfileImageSettingDelegate {
    func didSelectProfileImage(_ image: UIImage) {
        profileCircleView.profileImageView.innerImageView.image = image
    }
}
