//
//  ProfileSettingViewModel.swift
//  Meaning Out
//
//  Created by dopamint on 7/9/24.
//

import Foundation

class ProfileSettingViewModel {
    
    var inputNickname: Observable<String?> = Observable("")
    var outputValidationText = Observable(NicknameGuide(rawValue: ""))
    var outputValid = Observable(false)
    
    init() {
        inputNickname.bind { _ in
            self.validateNickName()
        }
    }
    private func validateNickName() {
        guard let nickname = inputNickname.value else {
            return
        }
        let filteredText = nickname.components(separatedBy: ["#","$","@","%"]).joined()
        guard filteredText == inputNickname.value else {
            outputValidationText.value = .containedSpecialCharacter
            outputValid.value = false
            return
        }
        let filteredNumber = nickname.filter { $0.isNumber }
        guard filteredNumber.isEmpty else {
            outputValidationText.value =  .containedNumber
            outputValid.value = false
            return
        }
        guard 2..<10 ~= nickname.count else {
            outputValidationText.value = .invalidCount
            outputValid.value = false
            return
        }
        outputValidationText.value = .validNickname
        outputValid.value = true
    }
}
