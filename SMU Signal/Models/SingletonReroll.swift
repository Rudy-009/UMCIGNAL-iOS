//
//  SingletonReroll.swift
//  SMU Signal
//
//  Created by 이승준 on 4/20/25.
//

import Foundation

extension Singletone {
    static var rerollCount: Int = 0
    
    static func resetRerollCount() {
        rerollCount = 0
    }
    
    static func getReRollCount() -> Int {
        return rerollCount
    }
    
    static func setReRollCount(_ count: Int) {
        rerollCount = count
    }
}
