//
//  SearchResultViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/17/24.
//

import UIKit

import SnapKit
import Then



class SearchResultViewController: MeaningOutViewController, Configurable {
    
    
    var searchingProduct = ""
    var searchResultData: ShoppingDTO? {
        didSet {
            searchResultCollectionView.reloadData()
        }
    }
    lazy var searchedItemList = searchResultData?.items
    var page = 1
    var selectedSortMode = SortPriority(rawValue: SortPriority.accuracy.rawValue)
    
    lazy var searchResultCountLabel = UILabel().then {
        $0.font = Font.bold16
        $0.textColor = .main
    }
    var accuracyButton = SortButton(.accuracy)
    var recentDateButton = SortButton(.recentDate)
    var higherPriceButton = SortButton(.higherPrice)
    var lowerPriceButton = SortButton(.lowerPrice)
    
    lazy var sortButtons = [accuracyButton,
                              recentDateButton,
                              higherPriceButton,
                              lowerPriceButton]
    
    func setUpFilterButtons() {
        sortButtons.forEach {
            $0.addTarget(self, action: #selector(toggle), for: .touchUpInside)
        }
    }
    
    @objc
    func toggle(_ sender: SortButton) {
        for button in sortButtons {
            button.isSelected = (button == sender)
            selectedSortMode = sender.sortingMethod
            
            Network.requestSearchResult(query: searchingProduct, sort: sender.sortingMethod, page: page) { [self] data in
                searchResultData = data
                searchResultCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), 
                                                        at: .top,
                                                        animated: true)
            }
        }
        searchResultCollectionView.reloadData()
    }
    
    lazy var sortButtonStackView = UIStackView(arrangedSubviews: sortButtons).then {
        $0.alignment = .fill
        $0.distribution = .fillProportionally
        $0.spacing = 8
    }
    
    func collectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 10
        let cellSpacing: CGFloat = 20
        
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - cellSpacing
        layout.itemSize = CGSize(width: width / 2, height: width / 2 * 1.7)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = cellSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
    lazy var searchResultCollectionView = UICollectionView(frame: .zero,
                                                           collectionViewLayout: collectionViewLayout())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setUpFilterButtons()
        configureUI()
        configureHierachy()
        configureLayout()
        configureCollectionView()
    }

    func loadData() {
        Network.requestSearchResult(query: searchingProduct, sort: .accuracy, page: page) { [self] data in
            searchResultData = data
            searchResultCountLabel.text = "\(searchResultData?.total.formatted() ?? "0")개의 검색 결과"
            searchResultCollectionView.reloadData()
        }
    }
    
    func configureUI() {
        accuracyButton.isSelected = true
        navigationItem.title = searchingProduct
    }
    
    func configureHierachy() {
        view.addSubview(searchResultCountLabel)
        view.addSubview(sortButtonStackView)
        view.addSubview(searchResultCollectionView)
    }
    
    func configureLayout() {
        searchResultCountLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        
        sortButtonStackView.snp.makeConstraints {
            $0.top.equalTo(searchResultCountLabel.snp.bottom).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).inset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).inset(30)
            $0.height.equalTo(40)
        }
        
        searchResultCollectionView.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.top.equalTo(sortButtonStackView.snp.bottom).offset(10)
        }
    }
    
    func configureCollectionView() {
        searchResultCollectionView.delegate = self
        searchResultCollectionView.dataSource = self
        searchResultCollectionView.prefetchDataSource = self
        searchResultCollectionView.register(SearchResultCollectionViewCell.self, forCellWithReuseIdentifier: SearchResultCollectionViewCell.id)
    }
}

extension SearchResultViewController: UICollectionViewDelegate,
                                      UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResultData?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchResultCollectionViewCell.id, for: indexPath) as! SearchResultCollectionViewCell
        cell.itemData = searchResultData?.items[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let produtName = searchResultData?.items[indexPath.item].title ?? ""
        let productDetailUrl = searchResultData?.items[indexPath.item].link.removeHTMLTags() ?? ""
        let vc = ProductDetailViewController(produtName, productDetailUrl, id: searchResultData?.items[indexPath.item].productId ?? "")
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension SearchResultViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        
        for indexPaths in indexPaths {
            guard let list = searchResultData?.items, let selectedSortMode else {
                return
            }
            if list.count - 2 <= indexPaths.item {
                page += 1
                Network.requestSearchResult(query: searchingProduct, sort: selectedSortMode, page: page) { data in
                    self.searchResultData?.items.append(contentsOf: data.items)
                    self.searchResultCollectionView.reloadData()
                }
            }
        }
    }
    
    private func collectionView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Cancel Prefetch \(indexPaths)")
    }
}


