//
//  SingletonReferral.swift
//  SMU Signal
//
//  Created by 이승준 on 4/22/25.
//

import Foundation

extension Singletone {
    
    static var referral: String = ""
    
    static func setReferral(_ referral: String) {
        self.referral = referral
    }
    
    static func getReferral() -> String {
        return referral
    }
}
