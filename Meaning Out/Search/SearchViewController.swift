//
//  SearchViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

import SnapKit
import Then

class SearchViewController: MeaningOutViewController, Configurable {

    let productSearchBar = UISearchBar()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureHierachy()
        configureLayout()
    }
    func configureUI() {
        navigationItem.title = "이지's MEANING OUT"

    }
    func configureHierachy() {
        view.addSubview(productSearchBar)
    }
    
    func configureLayout() {
        productSearchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
}
