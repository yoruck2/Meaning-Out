//
//  searchResultCollectionViewCell.swift
//  Meaning Out
//
//  Created by dopamint on 6/18/24.
//

import UIKit

import Kingfisher

final class SearchResultCollectionViewCell: UICollectionViewCell, Configurable {
    
    let repository = WishListTableRepository.shared
    
    var itemData: Item? {
        didSet {
            setUpData()
        }
    }
    
    let productImageView = UIImageView().then {
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    lazy var wishButton = WishButton(cellProductID: itemData?.productId ?? "",
                                     isWished: (UserDefaultsHelper.standard.wishList[itemData?.productId ?? ""] != nil))
    
    let sellerLabel = UILabel().then {
        $0.font = Font.medium13
        $0.textColor = .lighterGray
    }
    
    let productNameLabel = UILabel().then {
        $0.numberOfLines = 2
        $0.font = Font.medium15
    }
    
    let priceLabel = UILabel().then {
        $0.font = Font.bold16
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpData()
        configureHierachy()
        configureLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        guard let  wishData = UserDefaultsHelper.standard.wishList[itemData?.productId ?? ""]
        else {
            wishButton.isSelected = false
            return
        }
        isSelected = wishData as! Bool
    }
    
    // MARK: id 확인 -
    func setUpData() {
        guard let itemData else {
            return
        }
        wishButton.isSelected = (UserDefaultsHelper.standard.wishList[itemData.productId] != nil)
        
        let url = URL(string: itemData.image)
        productImageView.kf.setImage(with: url)
        sellerLabel.text = itemData.mallName
        productNameLabel.text = itemData.title.removeHTMLTags()
        priceLabel.text = "\(itemData.lprice)원"
        wishButton.cellProductID = itemData.productId
        wishButton.itemData = itemData  
    }
    
    func configureHierachy() {
        contentView.addSubview(productImageView)
        contentView.addSubview(wishButton)
        contentView.addSubview(sellerLabel)
        contentView.addSubview(productNameLabel)
        contentView.addSubview(priceLabel)
    }
    
    func configureLayout() {
        productImageView.snp.makeConstraints {
            $0.horizontalEdges.top.equalTo(contentView.safeAreaLayoutGuide)
            $0.height.equalTo(contentView.safeAreaLayoutGuide).multipliedBy(0.7)
        }
        
        wishButton.snp.makeConstraints {
            $0.trailing.equalTo(productImageView.snp.trailing).inset(20)
            $0.bottom.equalTo(productImageView.snp.bottom).inset(20)
            $0.height.equalTo(30)
            $0.width.equalTo(wishButton.snp.height)
        }
        
        sellerLabel.snp.makeConstraints {
            $0.top.equalTo(productImageView.snp.bottom).offset(3)
            $0.horizontalEdges.equalTo(productImageView).inset(5)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(sellerLabel.snp.bottom)
            $0.horizontalEdges.equalTo(productImageView).inset(5)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(3)
            $0.horizontalEdges.equalTo(productImageView).inset(5)
            $0.bottom.lessThanOrEqualTo(contentView.safeAreaLayoutGuide)
        }
    }
}
