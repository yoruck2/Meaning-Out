//
//  UIViewController.swift
//  Meaning Out
//
//  Created by dopamint on 6/15/24.
//

import UIKit

enum AlertType {
    case withdrawal
    case networkError(error: String)
    
    var title: String {
        switch self {
        case .withdrawal:
            return "탈퇴하기"
        case .networkError:
            return "네트워크 오류"
        }
    }
    
    var message: String {
        switch self {
        case .withdrawal:
            return "탈퇴를 하면 데이터가 모두 초기화됩니다. 탈퇴 하시겠습니까?"
        case .networkError(let error):
            return "\(error)\n다시 시도해주세요"
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
    
    func showConfirmCancelAlert(alertType: AlertType, completion: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: alertType.title,
                                      message: alertType.message,
                                      preferredStyle: .alert)
        
        alert.addAction("확인", .destructive, handler: completion)
        alert.addAction("취소", .cancel)
        self.present(alert, animated: true)
    }
    
    func showConfirmAlert(alertType: AlertType) {
        let alert = UIAlertController(title: alertType.title,
                                      message: alertType.message,
                                      preferredStyle: .alert)
        
        alert.addAction("확인", .default)
        self.present(alert, animated: true)
    }
}
