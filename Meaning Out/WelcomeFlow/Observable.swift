//
//  Observable.swift
//  Meaning Out
//
//  Created by dopamint on 7/9/24.
//

import Foundation

class Observable<T> {
    var closure: ((T) -> Void)?
    
    var value: T {
        didSet {
            print("didSet")
            closure?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    // 클로저받아서 실행시키고 바로
    func bind(closure: @escaping (T) -> Void) {
//        closure(value)
        self.closure = closure
    }
}
