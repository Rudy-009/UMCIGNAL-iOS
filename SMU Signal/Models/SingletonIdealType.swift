//
//  IdealTypeInfo.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import Foundation

struct IdealTypeInfo: Codable {
    var idle_MBTI: String?
    var age_gap: Int?
    var smoking_idle: Bool?
    var drinking_idle: Int?
    var sameMajor: Int?
    var major_idle: [String]?
}

extension Singletone {
    static var idealType = IdealTypeInfo()
    
    static func typeIdealMBTI(_ mbti: String) {
        idealType.idle_MBTI = mbti
    }
    
    static func typeAgeGap(_ ageGap: Int) {
        idealType.age_gap = ageGap
    }
    
    static func typeSmokingIdle(_ smokingIdle: Bool) {
        idealType.smoking_idle = smokingIdle
    }
    
    static func typeDrinkingIdle(_ drinkingIdle: Int) {
        idealType.drinking_idle = drinkingIdle
    }
    
    static func typeMajorIdle(_ majorIdle: Int) {
        idealType.sameMajor = majorIdle
    }
    
    static func removeIdealTypeInfo() {
        idealType = IdealTypeInfo()
    }
}
