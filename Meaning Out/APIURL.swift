//
//  APIURL.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import Foundation
    
struct APIURL {
    static let shoppingURL = "https://www.dhlottery.co.kr/common.do?method=getLottoNumber&drwNo="
}

enum APIType {
    case movieAPI
    case weatherAPI

    var APIkey: String {
        let keyName: String
        
        switch self {
        case .movieAPI:
            keyName = "MOVIE_API_KEY"
        case .weatherAPI:
            keyName = "WEATHER_API_KEY"
        }
        guard let key = Bundle.main.object(forInfoDictionaryKey: keyName) as? String else {
            assertionFailure("API_KEY를 찾을 수 없음")
            return ""
        }
        return key
    }
}
