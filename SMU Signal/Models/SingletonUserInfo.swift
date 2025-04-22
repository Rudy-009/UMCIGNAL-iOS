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

class Singletone {
    static var userInfo = UserInfo()
    
    // Combine 퍼블리셔 추가
    static let smokingSubject = CurrentValueSubject<Bool?, Never>(userInfo.is_smoking)
    static let genderSubject = CurrentValueSubject<String?, Never>(userInfo.gender)
    static let nameSubject = CurrentValueSubject<String?, Never>(userInfo.name)
    static let studentMajorSubject = CurrentValueSubject<String?, Never>(userInfo.student_major)
    static let mbtiSubject = CurrentValueSubject<String?, Never>(userInfo.MBTI)
    static let drinkingSubject = CurrentValueSubject<Int?, Never>(userInfo.is_drinking)
    static let instagramIdSubject = CurrentValueSubject<String?, Never>(userInfo.instagram_id)
    static let ageSubject = CurrentValueSubject<String?, Never>(userInfo.age)
    
    static func typeGender(_ gender: String) {
        Singletone.userInfo.gender = gender
        genderSubject.send(gender)
    }
    
    static func typeName(_ name: String) {
        Singletone.userInfo.name = name
        nameSubject.send(name)
    }
    
    static func typeStudentMajor(_ studentMajor: String) {
        Singletone.userInfo.student_major = studentMajor
        studentMajorSubject.send(studentMajor)
    }
    
    static func typeMBTI(_ MBTI: String) {
        Singletone.userInfo.MBTI = MBTI
        mbtiSubject.send(MBTI)
    }
    
    static func typeIsSmoking(_ isSmoking: Bool) {
        Singletone.userInfo.is_smoking = isSmoking
        smokingSubject.send(isSmoking)
    }
    
    static func typeIsDrinking(_ isDrinking: Int) {
        Singletone.userInfo.is_drinking = isDrinking
        drinkingSubject.send(isDrinking)
    }
    
    static func typeInstagramId(_ instagramId: String) {
        Singletone.userInfo.instagram_id = instagramId
        instagramIdSubject.send(instagramId)
    }
    
    static func typeAge(_ age: String) {
        Singletone.userInfo.age = age
        ageSubject.send(age)
    }
    
    static func saveUserInfo(_ info: UserInfo) {
        Singletone.userInfo = info
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
    
    static func clearUserInfo() {
        userInfo = UserInfo()
        // 모든 Subject 초기화
        genderSubject.send(nil)
        nameSubject.send(nil)
        studentMajorSubject.send(nil)
        mbtiSubject.send(nil)
        smokingSubject.send(nil)
        drinkingSubject.send(nil)
        instagramIdSubject.send(nil)
        ageSubject.send(nil)
        
        // UserDefaults에서 사용자 정보 삭제
        UserDefaults.standard.removeObject(forKey: "userInfo")
    }
    
}
