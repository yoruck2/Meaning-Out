//
//  LargeCapsuleButton.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import UIKit
import Then

enum LargeCapsuleButtonStyle: String {
    case start = "시작하기"
    case complete = "완료"
}

class LargeCapsuleButton: UIButton {
    
    weak var delegate: SendDataDelegate?
    
    override var isHighlighted: Bool {
        get {
            return super.isHighlighted
        }
        set {
            if newValue {
                backgroundColor = .mainColorSelected
            } else {
                backgroundColor = .main
            }
        }
    }
    
    override var isEnabled: Bool {
        didSet {
            alpha = isEnabled ? 1.0 : 0.5
        }
    }
    
    init(style: LargeCapsuleButtonStyle) {
        super.init(frame: .zero)
        setTitle(style.rawValue, for: .normal)
        
        titleLabel?.font =  Font.bold16
        backgroundColor = .main
        layer.cornerRadius = 20
        addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func buttonTapped() {
        delegate?.transfer()
    }
}

