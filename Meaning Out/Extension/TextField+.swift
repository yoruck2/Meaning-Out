//
//  TextField+.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit

extension UITextField {
    func addBottomBorder(with color: UIColor?, width borderWidth: CGFloat) {
        let border = UIView()
        border.autoresizingMask = [.flexibleWidth, .flexibleTopMargin]
        border.backgroundColor = color
        border.frame = CGRect(x: 0, 
                              y: frame.height - borderWidth,
                              width: frame.width,
                              height: borderWidth)
        
        self.addSubview(border)
    }
}


