//
//  MeaningOutTabBarController.swift
//  Meaning Out
//
//  Created by dopamint on 6/16/24.
//

import UIKit

class MeaningOutTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let firstVC = UINavigationController(rootViewController: SearchViewController())
        let secondVC = UINavigationController(rootViewController: SettingViewController())

        
        setViewControllers([firstVC, secondVC],
                                            animated: true)
        tabBar.tintColor = .main
        tabBar.backgroundColor = .white
        
        if let items = tabBar.items {
            items[0].image = UIImage(systemName: "person")
            items[0].title = "검색"
        
            items[1].image = UIImage(systemName: "magnifyingglass")
            items[1].title = "설정"
        }
    }

}
