//
//  APIURL.swift
//  Meaning Out
//
//  Created by dopamint on 7/1/24.
//

import Foundation

enum APIURL {
    case search(query: String, sort: SortPriority, page: Int)
    
    var scheme: String {
        return "https"
    }
     var host: String {
        return "openapi.naver.com"
    }
     var path: String {
        return "/v1/search/shop.json"
    }
    
    var header: [String : String]  {
        return ["X-Naver-Client-Id": APIAuth.clientId.header,
                "X-Naver-Client-Secret": APIAuth.clientSecret.header,]
    }
    
    var parameter: [URLQueryItem]  {
        switch self {
        case .search(let query, let sort, let page):
            return [URLQueryItem(name: "query", value: query),
                    URLQueryItem(name: "display", value: "30"),
                    URLQueryItem(name: "sort", value: sort.parameterValue),
                    URLQueryItem(name: "start", value: String(page))]
        }
    }
}
