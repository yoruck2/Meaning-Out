//
//  ProfileImageSettingViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

import SnapKit
import Then

// TODO: 진입 시 적용되어있는 이미지가 highlited 가 되어야 함

class ProfileImageSettingViewController: MeaningOutViewController, Configurable {
    
    var profileCircleView = ProfileCircleView()
    weak var delegate: ProfileImageSettingDelegate?
    
    lazy var profileImageSettingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.profileCollectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        configureHierachy()
        configureLayout()
        configureCollectionView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.didSelectProfileImage(profileCircleView.profileImageView.innerImageView.image!)
    }
    
    func configureHierachy() {
        view.addSubview(profileCircleView)
        view.addSubview(profileImageSettingCollectionView)
    }
    
    func configureLayout() {
        profileCircleView.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(30)
            $0.width.equalTo(view.safeAreaLayoutGuide).multipliedBy(0.3)
            $0.height.equalTo(profileCircleView.snp.width)
        }
        
        profileImageSettingCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileCircleView.snp.bottom).offset(50)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
    func configureUI() {
        navigationItem.title = "PROFILE SETTING"
    }
}

extension ProfileImageSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func configureCollectionView() {
        profileImageSettingCollectionView.delegate = self
        profileImageSettingCollectionView.dataSource = self
        profileImageSettingCollectionView.register(ProfileImageSettingCollectionViewCell.self, forCellWithReuseIdentifier: ProfileImageSettingCollectionViewCell.id)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileImageSettingCollectionViewCell.id, for: indexPath) as! ProfileImageSettingCollectionViewCell
        
        cell.profileImageView.image = UIImage(named: "profile_" + "\(indexPath.item)")
        if profileCircleView.profileImageView.innerImageView.image == cell.profileImageView.image {
            cell.profileImageView.isHighlighted = true
//            cell.profileImageView.layer.borderColor = UIColor(resource: .main).cgColor
//            cell.profileImageView.layer.borderWidth = 3
//            cell.profileImageView.alpha = 1
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! ProfileImageSettingCollectionViewCell
        profileCircleView.profileImageView.innerImageView.image = cell.profileImageView.image
    }
}



