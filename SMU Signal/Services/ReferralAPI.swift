//
//  ReferralAPI.swift
//  SMU Signal
//
//  Created by 이승준 on 4/22/25.
//

import Alamofire
import Foundation

struct ReferralCodeResponse: Codable {
    let message: String
    let result: String?
}

struct UseReferralResponse: Codable {
    let message: String?
    let result: String?
}

struct UseReferralResult: Codable {
    let user_id: Int?
    let referral_code: String?
}

struct InserCodeResponse: Codable {
    let message: String
    let result: Int?
}

enum RerollCode: Int {
    case success = 202
    case expired = 401
    case nomore = 403
    case failed = 404
    case error   = 500
}

struct RerollResponse: Codable {
    let result: RerollResult
    let message: String
}

struct RerollResult: Codable {
    let findUser: ResultUser?
    let idleScore: Int?
}

struct ResultUser: Codable {
    let user_id : Int?
    let is_smoking : Int?
    let is_drinking : String?
    let idle_MBTI : String?
    let idle_major : String?
    let instagram_id : String?
    let idle_age : Int?
}

enum ReferralCode: Int {
    case success = 200 //..<300
    case notLogined = 401 // 로그인 되어 있지 않을 때 (401): '로그인 되어있지 않습니다.'
    case expired = 403
    case notFound = 404 // 토큰이 없을 때 (404): '토큰이 없습니다.', 추천 코드가 없을 때 (404): '추천 코드가 없습니다.'
    case alreadyUsed = 409 // 사용된 코드
    case error   = 500 // 서버 에러 (500): '서버 에러입니다.'
}

enum SericalCode: Int {
    case success = 200 //..<300
    case alreadyUsed = 400 // 이미 사용된 코드일 때 (400): '이미 사용된 코드입니다.'
    case exporedToken = 401  // 토큰이 유효하지 않을 때 (401): '토큰이 유효하지 않습니다.', // 로그인 되어 있지 않을 때 (401): '로그인 되어있지 않습니다.'
    case expired = 403
    case notFound = 404 // 코드가 없을 때 (404): '코드를 입력해주세요.', 존재하지 않는 코드일 때 (404): '존재하지 않는 코드입니다.'
    case error = 500 // 서버 에러 (500): '서버 에러입니다.' - 없는 serical Code일 때
}

extension APIService {
    
    static func getReferralCode(completion: @escaping (ReferralCode) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else { return }
        let url = K.baseURLString + "/referral/getMyReferralCode"
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request(
            url,
            method: .get,
            headers: headers
        ).responseDecodable(of: ReferralCodeResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                let statusCode = response.response!.statusCode
                switch statusCode {
                case 200..<300:
                    if let code = apiResponse.result {
                        Singletone.setReferral(code)
                    }
                    completion(.success)
                case 400..<500:
                    completion(.expired)
                default:
                    completion(.error)
                }
            case .failure(_):
                completion(.error)
            }
        }
    }
    
    static func useReferralCode(code: String, completion: @escaping (ReferralCode, String) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else { return }
        let url = K.baseURLString + "/referral/findReferralCode"
        let parameters: [String: Any] = [
            "referralCode": code
        ]
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request(
            url,
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseDecodable(of: UseReferralResponse.self) { response in
            switch response.result {
            case .success(_):
                let message = response.value?.message ?? "no message"
                let statusCode = response.response!.statusCode
                switch statusCode {
                case 200..<300:
                    print("success \(message)")
                    completion(.success, message)
                case 401:
                    completion(.notLogined, message)
                case 403:
                    completion(.expired, message)
                case 404:
                    completion(.notFound, message)
                case 409:
                    completion(.alreadyUsed, message)
                default:
                    print("/referral/findReferralCode, \(message)")
                    completion(.error, message)
                }
            case .failure(let error):
                print("/referral/findReferralCode \(error)")
            }
        }
    }
    
    static func useSerialCode(code: String, completion: @escaping (SericalCode, String) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else { return }
        let url = K.baseURLString + "/serialCode/insertCode"
        let parameters: [String: Any] = [
            "serialCode": code
        ]
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        AF.request(
            url,
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseDecodable(of: InserCodeResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                let message = apiResponse.message
                let statusCode = response.response!.statusCode
                switch statusCode {
                case 200..<300:
                    print("success \(message)")
                    completion(.success, message)
                case 400:
                    completion(.alreadyUsed, message)
                case 401:
                    completion(.exporedToken, message)
                case 403:
                    completion(.expired, message)
                case 404:
                    completion(.notFound, message)
                default:
                    print("/application/json error \(message)")
                    completion(.error, message)
                }
            case .failure(let error):
                print("/serialCode/insertCode error \(error)")
            }
        }
    }
    
    static func getReroll(completion: @escaping (RerollCode, String?) -> Void ) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else { return }
        let url = K.baseURLString + "/idleType/reroll"
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        AF.request(
            url,
            method: .get,
            headers: headers
        ).responseDecodable(of: RerollResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                print(apiResponse)
                let statusCode = response.response!.statusCode
                switch statusCode {
                case 200..<300:
                    completion(.success, apiResponse.result.findUser?.instagram_id)
                case 400:
                    completion(.nomore, nil)
                case 403:
                    completion(.expired, nil)
                case 404:
                    completion(.failed, nil)
                case 500:
                    completion(.error, nil)
                default :
                    completion(.error, nil)
                }
            case .failure(let error):
                print("/idleType/reroll get error: \(error)")
                completion(.error, nil)
            }
        }
    }
    
}

