//
//  UserDefaultsHelper.swift
//  Meaning Out
//
//  Created by dopamint on 6/17/24.
//

import UIKit

enum Key: String {
    case nickname
    case recentSearchList
    case wishList
    case signUpDate
    case profileImage
}

final class UserDefaultsHelper {
    static let standard = UserDefaultsHelper()
    private init() {}
    
    let userDefaults = UserDefaults.standard
    
    var nickname: String {
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue) ?? ""
        }
        set {
            userDefaults.set(newValue,forKey: Key.nickname.rawValue)
        }
    }

    var recentSearchList: [String] {
        get {
            return userDefaults.stringArray(forKey: Key.recentSearchList.rawValue) ?? []
        }
        set {
            userDefaults.set(newValue, forKey: Key.recentSearchList.rawValue)
        }
    }
    
    var wishList: [String: Any] {
        
        get {
            return userDefaults.dictionary(forKey: Key.wishList.rawValue) ?? [:]
        }
        set {
            userDefaults.set(newValue, forKey: Key.wishList.rawValue)
        }
    }
    
    var signUpDate: String {
        get {
            return userDefaults.string(forKey: Key.signUpDate.rawValue) ?? ""
        }
        set {
            userDefaults.set(newValue, forKey: Key.signUpDate.rawValue)
        }
    }
    
    var profileImage: UIImage {
        get {
            do {
                guard let url = userDefaults.url(forKey: Key.profileImage.rawValue) else {
                    return UIImage()
                }
                let imageData = try Data(contentsOf: url)
                
                guard let image = UIImage(data: imageData) else {
                    return UIImage()
                }
                
                return image
                
            } catch {
                print(error)
            }
            return UIImage()
        }
        set {
            // 새 이미지를 Data 타입으로 변환
            let image = newValue
            guard let data = image.pngData() else {
                print("이미지 없음")
                return
            }
            let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            lazy var url = documents.appendingPathComponent("userProfileImage.png")
            // url에 data을 저장
            do {
                try data.write(to: url)
                // url 경로를 userDefaults에 저장
                userDefaults.set(url, forKey: Key.profileImage.rawValue)
            } catch {
                print(error)
            }
        }
    }
}


