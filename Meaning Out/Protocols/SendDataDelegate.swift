//
//  SendDataDelegate.swift
//  Meaning Out
//
//  Created by dopamint on 6/16/24.
//

import UIKit

protocol SendDataDelegate: AnyObject {
    func transfer(data: Any)
}

protocol ProfileImageSettingDelegate: AnyObject {
    func didSelectProfileImage(_ image: UIImage)
}

protocol recentSearchDelegate: AnyObject {
    func removeRecentSearch(index : Int)
}
