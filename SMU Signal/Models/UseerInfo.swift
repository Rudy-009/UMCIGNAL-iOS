//
//  UseerInfo.swift
//  UMCignal
//
//  Created by 이승준 on 4/10/25.
//

import Foundation

struct UserInfo: Codable {
    var gender: String?
    var name: String?
    var student_major: String?
    var MBTI: String?
    var is_smoking: Bool?
    var is_drinking: Int?
    var instagram_id: String?
    var age: String?
    var nickname: String?
}

class UserInfoSingletone {
    static var shared = UserInfo()
    
    static func typeGender(_ gender: String) {
        UserInfoSingletone.shared.gender = gender
    }
    
    static func typeName(_ name: String) {
        UserInfoSingletone.shared.name = name
    }
    
    static func typeStudentMajor(_ studentMajor: String) {
        UserInfoSingletone.shared.student_major = studentMajor
    }
    
    static func typeMBTI(_ MBTI: String) {
        UserInfoSingletone.shared.MBTI = MBTI
    }
    
    static func typeIsSmoking(_ isSmoking: Bool) {
        UserInfoSingletone.shared.is_smoking = isSmoking
    }
    
    static func typeIsDrinking(_ isDrinking: Int) {
        UserInfoSingletone.shared.is_drinking = isDrinking
    }
    
    static func typeInstagramId(_ instagramId: String) {
        UserInfoSingletone.shared.instagram_id = instagramId
    }
    
    static func typeAge(_ age: String) {
        UserInfoSingletone.shared.age = age
    }
    
    static func nickname(_ nickname: String) {
        UserInfoSingletone.shared.nickname = nickname
    }
}
