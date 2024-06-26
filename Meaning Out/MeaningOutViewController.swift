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
        
        view.backgroundColor = .white
        configureNavigationBar()
        hideKeyboardWhenTappedAround()
    }
    func configureNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.tintColor = .black
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.backward"),
                                                           style: .plain,
                                                           target: self,
                                                           action: #selector(backbuttonTapped))
    }
    
    @objc
    func backbuttonTapped() {
        self.navigationController?.popViewController(animated: true)
    }
}
