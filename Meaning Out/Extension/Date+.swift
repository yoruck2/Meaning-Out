//
//  Date.swift
//  Meaning Out
//
//  Created by dopamint on 6/18/24.
//

import Foundation

extension Date {
    
    static func todayString() -> String {
        var formatter = DateFormatter()
        formatter.dateFormat = "yyyy. MM. dd"
        var resultString = formatter.string(from: Date())
        return resultString
    }
}
