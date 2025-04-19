//
//  UseerInfo.swift
//  UMCignal
//
//  Created by 이승준 on 4/10/25.
//

import Foundation
import Combine

struct UserInfo: Codable {
    var gender: String?
    var name: String? = nil
    var student_major: String?
    var MBTI: String?
    var is_smoking: Bool?
    var is_drinking: Int?
    var instagram_id: String?
    var age: String?
}

class UserInfoSingletone {
    static var shared = UserInfo()
    
    // Combine 퍼블리셔 추가
    static let smokingSubject = CurrentValueSubject<Bool?, Never>(shared.is_smoking)
    static let genderSubject = CurrentValueSubject<String?, Never>(shared.gender)
    static let nameSubject = CurrentValueSubject<String?, Never>(shared.name)
    static let studentMajorSubject = CurrentValueSubject<String?, Never>(shared.student_major)
    static let mbtiSubject = CurrentValueSubject<String?, Never>(shared.MBTI)
    static let drinkingSubject = CurrentValueSubject<Int?, Never>(shared.is_drinking)
    static let instagramIdSubject = CurrentValueSubject<String?, Never>(shared.instagram_id)
    static let ageSubject = CurrentValueSubject<String?, Never>(shared.age)
    
    static func typeGender(_ gender: String) {
        UserInfoSingletone.shared.gender = gender
        genderSubject.send(gender)
    }
    
    static func typeName(_ name: String) {
        UserInfoSingletone.shared.name = name
        nameSubject.send(name)
    }
    
    static func typeStudentMajor(_ studentMajor: String) {
        UserInfoSingletone.shared.student_major = studentMajor
        studentMajorSubject.send(studentMajor)
    }
    
    static func typeMBTI(_ MBTI: String) {
        UserInfoSingletone.shared.MBTI = MBTI
        mbtiSubject.send(MBTI)
    }
    
    static func typeIsSmoking(_ isSmoking: Bool) {
        UserInfoSingletone.shared.is_smoking = isSmoking
        smokingSubject.send(isSmoking)
    }
    
    static func typeIsDrinking(_ isDrinking: Int) {
        UserInfoSingletone.shared.is_drinking = isDrinking
        drinkingSubject.send(isDrinking)
    }
    
    static func typeInstagramId(_ instagramId: String) {
        UserInfoSingletone.shared.instagram_id = instagramId
        instagramIdSubject.send(instagramId)
    }
    
    static func typeAge(_ age: String) {
        UserInfoSingletone.shared.age = age
        ageSubject.send(age)
    }
    
    static func saveUserInfo(_ info: UserInfo) {
        UserInfoSingletone.shared = info
        
        // 모든 Subject 업데이트
        genderSubject.send(info.gender)
        nameSubject.send(info.name)
        studentMajorSubject.send(info.student_major)
        mbtiSubject.send(info.MBTI)
        smokingSubject.send(info.is_smoking)
        drinkingSubject.send(info.is_drinking)
        instagramIdSubject.send(info.instagram_id)
        ageSubject.send(info.age)
    }
    
}
