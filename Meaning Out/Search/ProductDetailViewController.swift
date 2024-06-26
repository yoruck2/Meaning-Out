//
//  ProductDetailViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/22/24.
//

import UIKit
import WebKit

final class ProductDetailViewController: MeaningOutViewController {
    
    private var produtName: String
    private var productID: String
    private var productDetailUrl: String
    
    private let webView: WKWebView = WKWebView()
    
    init(_ produtName: String, _ productDetailUrl: String, id productID: String) {
        self.produtName = produtName
        self.productDetailUrl = productDetailUrl
        self.productID = productID
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = produtName.removeHTMLTags()
        configureWebView()
        configureUI()
    }
    
    override func configureNavigationBar() {
        let barButton = CartButton(cellProductID: productID).toBarButtonItem()
        print(UserDefaultsHelper.standard.cartList[productID])
        if UserDefaultsHelper.standard.cartList[productID] != nil {
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
        guard let url = URL(string: productDetailUrl) else {
            return
        }
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
