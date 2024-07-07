//
//  MeaningOutTabBarController.swift
//  Meaning Out
//
//  Created by dopamint on 6/16/24.
//

import UIKit

final class MeaningOutTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let searchVC = UINavigationController(rootViewController: SearchViewController())
        let wishListVC = UINavigationController(rootViewController: WishlistViewController())
        let settingVC = UINavigationController(rootViewController: SettingViewController())

        setViewControllers([searchVC, settingVC], animated: true)
        tabBar.tintColor = .main
        tabBar.backgroundColor = .white
        
        if let items = tabBar.items {
            items[0].image = UIImage(systemName: "magnifyingglass")
            items[0].title = "검색"
            items[1].image = UIImage(systemName: "heart")
            items[1].selectedImage = UIImage(systemName: "heart.fillheart")
            items[1].title = "설정"
            items[2].image = UIImage(systemName: "person")
            items[2].title = "설정"
        }
    }

}
