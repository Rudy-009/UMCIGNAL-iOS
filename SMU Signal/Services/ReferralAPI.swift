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

enum ReferralCode: Int {
    case success = 200
    case error   = 500
    case noCode = 400
    case expired = 401
    case notFound = 404
    case alreadyUsed = 409
}

struct UseReferralResponse: Codable {
    let message: String
    let result: UseReferralResult?
}

struct UseReferralResult: Codable {
    let user_id: Int?
    let referral_code: String?
}

struct SerialResponse: Codable {
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
    
    static func useReferralCode(code: String, completion: @escaping (ReferralCode) -> Void) {
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
            headers: headers
        ).responseDecodable(of: UseReferralResponse.self) { response in
            let statusCode = response.response!.statusCode
            switch statusCode {
            case 200..<300:
                // Only try to decode successful responses
                if let data = response.data {
                    do {
                        _ = try JSONDecoder().decode(UseReferralResponse.self, from: data)
                        completion(.success)
                    } catch {
                        print("Decoding error for success response:", error)
                        completion(.error)
                    }
                } else {
                    completion(.success)
                }
            case 400:
                completion(.noCode)
            case 401:
                completion(.expired)
            case 404:
                completion(.notFound)
            case 409:
                print("already used")
                completion(.alreadyUsed)
            case 500...:
                completion(.error)
            default:
                completion(.error)
            }
        }
    }
    
    static func useSerialCode(code: String, completion: @escaping (ReferralCode) -> Void) {
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
            headers: headers
        ).responseDecodable(of: SerialResponse.self) { response in
            let statusCode = response.response!.statusCode
            switch statusCode {
            case 200..<300:
                // Only try to decode successful responses
                if let data = response.data {
                    do {
                        _ = try JSONDecoder().decode(UseReferralResponse.self, from: data)
                        completion(.success)
                    } catch {
                        print("Decoding error for success response:", error)
                        completion(.error)
                    }
                } else {
                    completion(.success)
                }
            case 400:
                completion(.noCode)
            case 401:
                completion(.expired)
            case 404:
                completion(.notFound)
            case 409:
                print("already used")
                completion(.alreadyUsed)
            case 500...:
                completion(.error)
            default:
                completion(.error)
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

