//
//  ProfileImageSettingViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

import SnapKit
import Then

class ProfileImageSettingViewController: MeaningOutViewController, Configurable {
    
    let profileCircleView = ProfileCircleView()
    
    let profileImageSelectionCollectionView = 
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func configureHierachy() {
        view.addSubview(profileCircleView)
    }
    
    func configureLayout() {
        <#code#>
    }
    
}
