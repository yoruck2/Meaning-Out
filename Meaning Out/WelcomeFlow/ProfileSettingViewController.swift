//
//  ProfileSettingViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

class ProfileSettingViewController: UIViewController, Configurable{

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        configureHierachy()
        configureLayout()
        configureUI()
    }
    
    func configureHierachy() {
        <#code#>
    }
    
    func configureLayout() {
        <#code#>
    }
    
    func configureUI() {
        view.backgroundColor = .white
        navigationItem.title = "PROFILE SETTING"
    }
}

extension ProfileSettingViewController
