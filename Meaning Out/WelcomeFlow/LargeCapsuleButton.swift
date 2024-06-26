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
    
    func setNextVC() -> UIViewController {
        switch self {
        case .start:
            return ProfileSettingViewController()
        case .complete:
            return ProfileImageSettingViewController()
        }
    }
}

class LargeCapsuleButton: UIButton {
    
    weak var delegate: SendDataDelegate?
    
    var nextView = UIViewController()
    
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
        
        nextView = style.setNextVC()
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
        delegate?.transfer(data: nextView)
    }
}

