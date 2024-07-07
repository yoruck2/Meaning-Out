//
//  WishListViewController.swift
//  Meaning Out
//
//  Created by dopamint on 7/8/24.
//

import UIKit

import SnapKit
import Then

class WishlistViewController: UIViewController, UISearchControllerDelegate {
    
    let repository = WishListTableRepository.shared
    
    let productSearchBar = UISearchController().then {
        $0.searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
    }
    let wishlistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.addSubview(productSearchBar.searchBar)
        view.addSubview(wishlistCollectionView)
    }
    func configureLayout() {
        wishlistCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    func configureView() {
        navigationItem.searchController = productSearchBar
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.leftBarButtonItem = nil
        productSearchBar.delegate = self
    }
}

extension WishlistViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        repository.wishlistTable.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
    }
    
    
}
