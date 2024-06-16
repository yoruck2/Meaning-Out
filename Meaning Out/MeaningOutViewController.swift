//
//  MeaningOutNavigationController.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

class MeaningOutViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let backBarButtonItem = UIBarButtonItem(title: "n",
                                                style: .plain,
                                                target: self,
                                                action: #selector(popVC))
        backBarButtonItem.tintColor = .black
        backBarButtonItem.image = UIImage(systemName: "chevron.backward")
        navigationItem.leftBarButtonItem = backBarButtonItem
        
        self.navigationItem.leftBarButtonItem?.tintColor = .green
        self.navigationItem.backBarButtonItem = backBarButtonItem
//        self.navigationItem.setLeftBarButton(backBarButtonItem, animated: true)
    }
    
    
    @objc
    func popVC() {
        popViewController(animated: true)
    }
    
}
