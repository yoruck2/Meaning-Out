//
//  ProductDetailViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/22/24.
//

import UIKit
import WebKit

final class ProductDetailViewController: MeaningOutViewController {
    
    private var itemData: Item
    private let webView: WKWebView = WKWebView()
    
    init(itemData: Item) {
        self.itemData = itemData
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = itemData.title.removeHTMLTags()
        configureWebView()
        configureUI()
    }
    
    // TODO: 구현해야함
    override func configureNavigationBar() {
        let isWished = UserDefaultsHelper.standard.wishList[itemData.productId]
        let barButton = WishButton(cellProductID: itemData.productId,
                                   isWished: (isWished != nil)).toBarButtonItem()
        
        print(UserDefaultsHelper.standard.wishList[itemData.productId])
        if UserDefaultsHelper.standard.wishList[itemData.productId] != nil {
            barButton?.isSelected.toggle()
        }
        navigationItem.rightBarButtonItem = barButton
    }
    private func configureUI() {
        view.addSubview(webView)
        webView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    private func configureWebView() {
        guard let url = URL(string: itemData.link) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
