//
//  APIURL.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import Foundation

enum APIAuth {
    case clientId
    case clientSecret

    var header: String {
        let keyName: String
        
        switch self {
        case .clientId:
            keyName = "X_Naver_Client_Id"
        case .clientSecret:
            keyName = "X_Naver_Client_Secret"
        }
        guard let key = Bundle.main.object(forInfoDictionaryKey: keyName) as? String else {
            assertionFailure("헤더를 찾을 수 없음")
            return ""
        }
        return key
    }
}
