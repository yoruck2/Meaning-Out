//
//  Network.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import Foundation

import Alamofire

struct Network {
    
    static func requestSearchResult(query: String, sort: SortPriority, page: Int, completion: @escaping (ShoppingDTO) -> Void) {
        let baseURL = APIURL.shoppingURL
        let parameters: Parameters = [
            "query": query,
            "display": 30,
            "sort": sort.parameterValue,
            "start": page
        ]
        let headers: HTTPHeaders = [
            "X-Naver-Client-Id": APIHeaders.clientId.header,
            "X-Naver-Client-Secret": APIHeaders.clientSecret.header,
        ]
        AF.request(baseURL,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .validate(statusCode: 200...500)
        .responseDecodable(of: ShoppingDTO.self) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
