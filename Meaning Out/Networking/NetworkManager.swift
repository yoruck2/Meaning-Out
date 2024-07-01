//
//  Network.swift
//  Meaning Out
//
//  Created by dopamint on 6/14/24.
//

import Foundation

enum NetworkError: String, Error {
    case failedRequest = "네트워크 요청실패"
    case noData = "데이터 오류"
    case invalidResponse = "유효하지 않은 응답"
    case invalidData
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    func requestSearchResult(api: APIURL,
                             completion: @escaping (ShoppingDTO?, NetworkError?) -> Void) {
        
        // MARK: URLComponents -
        var component = URLComponents()
        component.scheme = api.scheme
        component.host = api.host
        component.path = api.path
        component.queryItems = api.parameter
        
        // MARK: URLRequest -
        var request = URLRequest(url: component.url ?? URL(fileURLWithPath: ""))
        request.allHTTPHeaderFields = api.header
        
        let defaultSession = URLSession(configuration: .default)
        
        // MARK: URLSession -
        defaultSession.dataTask(with: request) { data, response, error in
            
            DispatchQueue.main.async {
                guard error == nil else {
                    completion(nil, .failedRequest)
                    return
                }
                
                guard let data else {
                    completion(nil, .noData)
                    return
                }
                
                guard let response = response as? HTTPURLResponse else {
                    completion(nil, .invalidResponse)
                    return
                }
            
                guard 200...299 ~= response.statusCode else {
                    completion(nil, .invalidResponse)
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(ShoppingDTO.self, from: data)
                    completion(result, nil)
//                    print(result)
                } catch {
                    completion(nil, .invalidData)
//                    print(error)
                }
            }
        }.resume()
    }
}
