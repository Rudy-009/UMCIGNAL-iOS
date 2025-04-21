//
//  SingletonEditUserInfo.swift
//  SMU Signal
//
//  Created by 이승준 on 4/21/25.
//

import Foundation

struct EditUserInfo: Codable {
    var MBTI: String?
    var is_smoking: Bool?
    var is_drinking: Int?
    var instagram_id: String?
}

extension Singletone {
    
    static var editUserInfo = EditUserInfo()
    
    static func editUserMBTI(_ mbti: String) {
        editUserInfo.MBTI = mbti
    }
    
    static func editSmoking(_ is_smoking: Bool) {
        editUserInfo.is_smoking = is_smoking
    }
    
    static func editDrinking(_ is_drinking: Int) {
        editUserInfo.is_drinking = is_drinking
    }
    
    static func editInstagram(_ instagram_id: String) {
        editUserInfo.instagram_id = instagram_id
    }
    
}
