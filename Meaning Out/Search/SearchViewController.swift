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
    
    var nonDuplicatedList = [String]()
    var recentSearchList = UserDefaultsHelper.standard.recentSearchList {
        didSet {
            toggleEmptyStateView()
            recentSearchTableView.reloadData()
        }
    }
    
    let productSearchBar = UISearchController().then {
        $0.searchBar.placeholder = "브랜드, 상품 등을 입력하세요."
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
        nonDuplicatedList.removeAll()
        UserDefaultsHelper.standard.userDefaults.removeObject(forKey: Key.recentSearchList.rawValue)
        recentSearchTableView.reloadData()
    }
    
    let recentSearchTableView = UITableView()
    
    func toggleEmptyStateView() {
        if recentSearchList.isEmpty {
            recentSearchTableView.isHidden = true
            header.isHidden = true
        } else {
            recentSearchTableView.isHidden = false
            header.isHidden = false
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        toggleEmptyStateView()
        configureUI()
        configureHierachy()
        configureLayout()
        ConfigureTableView()
        
        productSearchBar.searchBar.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let nickname = UserDefaultsHelper.standard.nickname
        navigationItem.title = "\(nickname)'s MEANING OUT"
        
    }
    func configureUI() {
        navigationItem.searchController = productSearchBar
        navigationItem.searchController?.hidesNavigationBarDuringPresentation = true
        navigationItem.hidesSearchBarWhenScrolling = false
        navigationItem.searchController?.obscuresBackgroundDuringPresentation = false
        navigationItem.leftBarButtonItem = nil
        recentSearchTableView.rowHeight = 40
    }
    func configureHierachy() {
        view.addSubview(productSearchBar.searchBar)
        view.addSubview(emptyStateImageView)
        view.addSubview(emptyStateLabel)
        view.addSubview(header)
        view.addSubview(recentSearchTableView)
    }
    
    func configureLayout() {
        emptyStateImageView.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        emptyStateLabel.snp.makeConstraints {
            $0.centerX.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(emptyStateImageView.snp.bottom).offset(10)
        }
        header.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.horizontalEdges.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.height.equalTo(45)
        }
        
        recentSearchTableView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(header.snp.bottom)
        }
    }
    
    func ConfigureTableView() {
        recentSearchTableView.separatorStyle = .none
        recentSearchTableView.delegate = self
        recentSearchTableView.dataSource = self
        recentSearchTableView.register(recentSearchTableViewCell.self,
                                       forCellReuseIdentifier: recentSearchTableViewCell.id)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else {
            return
        }
        
        if !recentSearchList.contains(text) {
            recentSearchList.insert(text, at: 0)
            UserDefaultsHelper.standard.recentSearchList = recentSearchList
        }
        
        let nextVC = SearchResultViewController()
        nextVC.searchingProduct = searchBar.text ?? ""
        navigationController?.pushViewController(nextVC,
                                                 animated: true)
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        recentSearchList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: recentSearchTableViewCell.id, for: indexPath) as! recentSearchTableViewCell
        cell.delegate = self
        
        cell.productNameLabel.text = recentSearchList[indexPath.row]
        cell.index = indexPath.row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! recentSearchTableViewCell
        
        let nextVC = SearchResultViewController()
        nextVC.searchingProduct = cell.productNameLabel.text ?? ""
        navigationController?.pushViewController(nextVC,
                                                 animated: true)
    }
}

extension SearchViewController: recentSearchDelegate {
    func removeRecentSearch(index: Int) {
        recentSearchList = UserDefaultsHelper.standard.recentSearchList
        recentSearchTableView.reloadData()
    }
}
