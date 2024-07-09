//
//  UICollectionView.swift
//  Meaning Out
//
//  Created by dopamint on 7/8/24.
//

import UIKit

extension UICollectionView {
    static func searchCollectionViewLayout() -> UICollectionViewLayout {
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
    
    static func profileCollectionViewLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        let sectionSpacing: CGFloat = 5
        let cellSpacing: CGFloat = 10
        let lineSpacing: CGFloat = 15
        let width = UIScreen.main.bounds.width - (sectionSpacing * 2) - (cellSpacing * 3)
        layout.itemSize = CGSize(width: width / 4.8, height: width / 4.8)
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = cellSpacing
        layout.minimumLineSpacing = lineSpacing
        layout.sectionInset = UIEdgeInsets(top: sectionSpacing, left: sectionSpacing, bottom: sectionSpacing, right: sectionSpacing)
        return layout
    }
}
