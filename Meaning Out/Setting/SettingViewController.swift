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
    
    lazy var profileAreaView = ProfileAreaView().then {
        let tapImageViewRecognizer = UITapGestureRecognizer(target: self,
                                                            action: #selector(profileTapped))
        $0.isUserInteractionEnabled = true
        $0.addGestureRecognizer(tapImageViewRecognizer)
    }
    let settingMenuTableView = UITableView()
    
    @objc
    func profileTapped(tapGestureRecognizer: UITapGestureRecognizer) {
        let nextVC = ProfileEditViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierachy()
        configureLayout()
        configureTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        profileAreaView.profileCircleView.image = UserDefaultsHelper.standard.profileImage
        profileAreaView.nicknameLabel.text = UserDefaultsHelper.standard.nickname
        settingMenuTableView.reloadData()
    }
    
    func configureUI() {
        navigationItem.title = "SETTING"
        navigationItem.leftBarButtonItem = nil
    }
    func configureHierachy() {
        view.addSubview(profileAreaView)
        view.addSubview(settingMenuTableView)
    }
    
    func configureLayout() {
        profileAreaView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(100)
        }
        
        settingMenuTableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(profileAreaView.snp.bottom)
        }
    }
    
    func configureTableView() {
        settingMenuTableView.separatorStyle = .singleLine
        settingMenuTableView.separatorColor = .darkerGray
        settingMenuTableView.delegate = self
        settingMenuTableView.dataSource = self
        settingMenuTableView.register(SettingMenuTableViewCell.self,
                                      forCellReuseIdentifier: SettingMenuTableViewCell.id)
    }
    
    func showAlert(completion: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: "탈퇴하기",
                                      message: "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?",
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인",
                               style: .destructive,
                               handler: completion)
        let cancel = UIAlertAction(title: "취소",
                                   style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
    
    func removeUserData() {
        for key in UserDefaultsHelper.standard.userDefaults.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    enum SettingMenu: String, CaseIterable {
        case myCartList = "나의 장바구니 목록"
        case FAQ = "자주 묻는 질문"
        case QnA = "1:1 문의"
        case NotificationSetting = "알림 설정"
        case withdraw = "탈퇴하기"
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        SettingMenu.allCases.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 4 {
            showAlert() {_ in
                self.removeUserData()
                
                let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
                let sceneDelegate = windowScene?.delegate as? SceneDelegate
                let vc = UINavigationController(rootViewController: WelcomeViewController())
                sceneDelegate?.changeRootVC(vc, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SettingMenuTableViewCell.id,
                                                 for: indexPath) as! SettingMenuTableViewCell
        if indexPath.section == 0 {
            cell.cartListCountLabel.isHidden = false
        } else {
            cell.cartListCountLabel.isHidden = true
        }
        
        cell.menuLabel.text = SettingMenu.allCases[indexPath.section].rawValue
        let cartCount = UserDefaultsHelper.standard.cartList.count
        cell.makeCartListCountLabel(cartCount: cartCount)
        return cell
    }
}

extension SettingViewController: ProfileImageSettingDelegate {
    func didSelectProfileImage(_ image: UIImage) {
        profileAreaView.profileCircleView.image = image
    }
}
