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


extension APIService {
    
    static func getReferralCode(completion: @escaping () -> Void) {
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
            case .success(let response):
                if let code = response.result {
                    Singletone.setReferral(code)
                }
            case .failure(let error):
                print("get referral code error: \(error)")
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
    
}

