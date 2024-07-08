//
//  WishListViewController.swift
//  Meaning Out
//
//  Created by dopamint on 7/8/24.
//

import UIKit

import SnapKit
import Then

class WishlistViewController: MeaningOutViewController, UISearchControllerDelegate {
    
    let repository = WishListTableRepository.shared
    
    let productSearchBar = UISearchController().then {
        $0.searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
    }
    lazy var wishlistCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionView.collectionViewLayout()).then {
        $0.delegate = self
        $0.dataSource = self
        $0.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureHierarchy()
        configureLayout()
        configureView()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadCollectionView),
                                               name: NSNotification.Name("reloadCollectinView"),
                                               object: nil)
    }
    @objc func reloadCollectionView(_ notification: Notification) {
        DispatchQueue.main.async {
            self.wishlistCollectionView.reloadData()
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        wishlistCollectionView.reloadData()
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
        let nickname = UserDefaultsHelper.standard.nickname
        navigationItem.title = "\(nickname)'s WISHLIST"
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as? SearchResultCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let wishItem = repository.wishlistTable[indexPath.item]
        let item = Item(title: wishItem.title,
                        link: wishItem.link,
                        image: wishItem.image ?? "",
                        lprice: wishItem.price ?? "",
                        hprice: "",
                        mallName: wishItem.mallName ?? "",
                        productId: wishItem.productId,
                        productType: "")
        cell.itemData = item
        return cell
    }
    
    
}
