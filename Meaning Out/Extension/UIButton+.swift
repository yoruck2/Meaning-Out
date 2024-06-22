//
//  UIButton+.swift
//  Meaning Out
//
//  Created by dopamint on 6/22/24.
//

import UIKit

extension UIButton {
    func toBarButtonItem() -> UIBarButtonItem? {
        return UIBarButtonItem(customView: self)
    }
}
