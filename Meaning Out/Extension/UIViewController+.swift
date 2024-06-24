//
//  UIViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/15/24.
//

import UIKit

enum AlertType: String {
    case withdrawal = "탈퇴하기"
    
    var message: String {
        switch self {
        case .withdrawal:
            return "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, 
                                         action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func showAlert(alerType: AlertType, completion: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: alerType.rawValue,
                                      message: alerType.message,
                                      preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인",
                               style: .destructive,
                               handler: completion)
        let cancel = UIAlertAction(title: "취소",
                                   style: .cancel)
        alert.addAction(ok)
        alert.addAction(cancel)
        
        self.present(alert, animated: true)
    }
}
