//
//  Constants.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

enum Color {
    
    static let mainColor: UIColor = UIColor(named: "mainColor") ?? .tintColor
    static let mainColorSelected: UIColor = UIColor(named: "mainColorSelected") ?? .tintColor
    static let background: UIColor = .white
    static let black: UIColor = .black
    static let darkerGray: UIColor = UIColor(named: "darkerGray") ?? .tintColor
    static let mediumGray: UIColor = UIColor(named: "mediumGray") ?? .tintColor
    static let lighterGray: UIColor = UIColor(named: "lightGray") ?? .tintColor
}

enum Font {
    
    static let mainTitle = UIFont(name: "AlfaSlabOne-Regular", size: 40)
    static let bold15 = UIFont.boldSystemFont(ofSize: 16)
    static let bold13 = UIFont.boldSystemFont(ofSize: 13)
}
