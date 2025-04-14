//
//  IdealTypeInfo.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import Foundation

struct IdealTypeInfo {
  var idle_MBTI: String?
  var age_gap: Int?
  var smoking_idle: Bool?
  var drinking_idle: Int?
  var major_idle: Bool?
}

class IdealTypeInfoSingletone {
    static var shared = IdealTypeInfo()
    
    static func typeIdealMBTI(_ mbti: String) {
        shared.idle_MBTI = mbti
    }
    
    static func typeAgeGap(_ ageGap: Int) {
        shared.age_gap = ageGap
    }
    
    static func typeSmokingIdle(_ smokingIdle: Bool) {
        shared.smoking_idle = smokingIdle
    }
    
    static func typeDrinkingIdle(_ drinkingIdle: Int) {
        shared.drinking_idle = drinkingIdle
    }
    
    static func typeMajorIdle(_ majorIdle: Bool) {
        shared.major_idle = majorIdle
    }
}
