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
    
    let network = NetworkManager.shared
    var searchingProduct = ""
    var searchResultData: Shopping? {
        didSet {
            searchResultCollectionView.reloadData()
        }
    }
    lazy var searchedItemList = searchResultData?.items
    var page = 1
    var selectedSortMode = SortPriority(rawValue: SortPriority.accuracy.rawValue)
    
    var total: Double = 0
    
    // TODO: 버퍼 -
    var buffer: Data? {
        didSet {
            let result = Double(buffer?.count ?? 0) / total
            progressLabel.text = "\(round(result * 100)) / 100"
        }
    }
    
    lazy var searchResultCountLabel = UILabel().then {
        $0.font = Font.bold16
        $0.textColor = .main
    }    
    lazy var progressLabel = UILabel().then {
        $0.font = Font.medium15
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
            
            network.requestSearchResult(api: .search(query: searchingProduct,
                                                     sort: sender.sortingMethod,
                                                     page: page)) { [self] data, error in
                guard error == nil else {
                    showConfirmAlert(alertType: .networkError(error: error?.rawValue ?? ""))
                    return
                }
                searchResultData = data
                searchResultCollectionView.scrollToItem(at: IndexPath(row: 0, 
                                                                      section: 0),
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
    
    
    lazy var searchResultCollectionView = UICollectionView(frame: .zero,
                                                           collectionViewLayout: UICollectionView.searchCollectionViewLayout())
    
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
        network.requestSearchResult(api: .search(query: searchingProduct,
                                                 sort: .accuracy,
                                                 page: page)) { [self] data, error  in
            guard error == nil else {
                showConfirmAlert(alertType: .networkError(error: error?.rawValue ?? ""))
                return
            }
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
        view.addSubview(progressLabel)
        view.addSubview(sortButtonStackView)
        view.addSubview(searchResultCollectionView)
    }
    
    func configureLayout() {
        searchResultCountLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.leading.equalTo(view.safeAreaLayoutGuide).offset(10)
        }
        progressLabel.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide).offset(10)
            $0.trailing.equalTo(view.safeAreaLayoutGuide).offset(10)
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
        guard let data = searchResultData?.items[indexPath.item] else {
            return
        }
        let vc = ProductDetailViewController(itemData: data)
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
                network.requestSearchResult(api: .search(query: searchingProduct,
                                                         sort: selectedSortMode,
                                                         page: page)) { [self] data, error in
                    guard error == nil else {
                        showConfirmAlert(alertType: .networkError(error: error?.rawValue ?? ""))
                        return
                    }
                    searchResultData?.items.append(contentsOf: data?.items ?? [])
                    searchResultCollectionView.reloadData()
                }
            }
        }
    }
    
    private func collectionView(_ tableView: UITableView, cancelPrefetchingForRowsAt indexPaths: [IndexPath]) {
        print("Cancel Prefetch \(indexPaths)")
    }
}


extension SearchResultViewController: URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse) async -> URLSession.ResponseDisposition {
        
        if let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) {
            let contentLength = response.value(forHTTPHeaderField: "Content-Length")!
            total = Double(contentLength)!
            
            progressLabel.text = "\(total)% 완료"
            
            return .allow
        } else {
            return .cancel
        }
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {

        buffer?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: (any Error)?) {
        
        if let error {
            progressLabel.text = "통신에 실패했습니다."
        } else {
            print("성공")
            
            guard let buffer else {
                print("buffer nil")
                return
            }
        }
    }
}
