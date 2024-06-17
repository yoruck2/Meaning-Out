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

    var recentSearchList = [String]()
    
    let productSearchBar = UISearchBar().then {
        $0.placeholder = "브랜드, 상품 등을 입력하세요."
    }
    
    let emptyStateImageView = UIImageView().then {
        $0.image = .empty
    }
    let emptyStateLabel = UILabel().then {
        $0.font = Font.bold16
        $0.text = "최근 검색어가 없어요"
    }
    
    lazy var header = TableViewHeader().then {
        $0.clearAllButton.addTarget(self, action: #selector(clearRecentSearch), for: .touchUpInside)
    }
    
    @objc
    func clearRecentSearch() {
        recentSearchList.removeAll()
        recentSearchTableView.reloadData()
    }
    
    let recentSearchTableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recentSearchList = ["qwer","asdf","zxcv"]
        configureUI()
        configureHierachy()
        configureLayout()
        ConfigureTableView()
        
        productSearchBar.delegate = self
    }
    func configureUI() {
        let nickname = UserDefaultsHelper.standard.nickname
        navigationItem.title = "\(nickname)'s MEANING OUT"
        navigationItem.leftBarButtonItem = nil
        recentSearchTableView.rowHeight = 40
    }
    func configureHierachy() {
        view.addSubview(productSearchBar)
        view.addSubview(emptyStateImageView)
        view.addSubview(emptyStateLabel)
        view.addSubview(header)
        view.addSubview(recentSearchTableView)
    }
    
    func configureLayout() {
        productSearchBar.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(view.safeAreaLayoutGuide)
        }
        emptyStateImageView.snp.makeConstraints {
            $0.center.equalTo(view.safeAreaLayoutGuide)
        }
        emptyStateLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(emptyStateImageView.snp.bottom).offset(10)
        }
        header.snp.makeConstraints {
            $0.top.equalTo(productSearchBar.snp.bottom)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(45)
        }
        
        recentSearchTableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(header.snp.bottom)
        }
        
        
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        navigationController?.pushViewController(SearchResultViewController(), animated: true)
        return true
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        navigationController?.pushViewController(SearchResultViewController(), animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func ConfigureTableView() {
        recentSearchTableView.separatorStyle = .none
        recentSearchTableView.delegate = self
        recentSearchTableView.dataSource = self
        recentSearchTableView.register(recentSearchTableViewCell.self, forCellReuseIdentifier: recentSearchTableViewCell.id)
    }
 

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recentSearchTableViewCell.id, for: indexPath) as! recentSearchTableViewCell
        cell.productNameLabel.text = recentSearchList[indexPath.row]
        return cell
    }
    
    
}
