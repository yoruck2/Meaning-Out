//
//  Configurable.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import Foundation

@objc
protocol Configurable: AnyObject {
    func configureHierachy()
    func configureLayout()
    @objc optional func configureUI()
}
