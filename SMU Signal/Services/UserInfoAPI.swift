//
//  UserInfoAPI.swift
//  SMU Signal
//
//  Created by 이승준 on 4/20/25.
//

import Alamofire

struct RerollCountResponse: Codable {
    let result: Int?
    let message: String
}

enum RerollCountCode: Int {
    case success = 202
    case error   = 500
    case expired = 401
    case missing = 404
}

struct ReferralCodeResponse: Codable {
    let message: String
    let result: String?
}

enum ReferralCode: Int {
    case success = 200
    case error   = 500
    case expired = 401
    case noCode = 400
}

struct EditedResponse: Codable {
    let message: String
    let missingFields: [String]?
}

struct InsResponse: Codable {
    let message: String?
    let result: String?
}

extension APIService {
    
    static func getRerollCount(completion: @escaping (RerollCountCode) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else {
            completion(.expired)
            return
        }
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        let url = K.baseURLString + "/serialCode/myReroll"
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default,
            headers: headers
        )
        .responseDecodable(of: RerollCountResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                guard let statusCode = response.response?.statusCode else {
                    completion(.missing)
                    return
                }
                print("reroll statusCode is ", statusCode)
                switch statusCode {
                case 200..<300:
                    print(apiResponse)
                    Singletone.setReRollCount(apiResponse.result!)
                    completion(.success)
                case 401:
                    completion(.expired)
                case 404:
                    completion(.missing)
                default:
                    completion(.error)
                }
            case .failure(_):
                print("get reroll error")
            }
        }
    }
    
    static func getReferralCode(completeion: @escaping () -> Void) {
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
                    print("referral code: \(code)")
                    Singletone.setReferral(code)
                }
                print("referral code is nil")
            case .failure(let error):
                print("get referral code error: \(error)")
            }
        }
    }
    
    static func editUserInfo() {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else { return }
        let url = K.baseURLString + "/user/changeInfo"
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        let editedInfo = Singletone.editUserInfo
        let parameters: [String: Any] = [
            "MBTI": editedInfo.MBTI!,
            "is_smoking": editedInfo.is_smoking! ,
            "is_drinking": editedInfo.is_drinking! ,
            "instagram_id": editedInfo.instagram_id!
        ]
        AF.request(
            url,
            method: .patch,
            parameters: parameters,
            headers: headers
        ).responseDecodable(of: EditedResponse.self) { response in
            switch response.result {
            case .success(_):
                RootViewControllerService.toHomeViewController()
            case .failure(let error):
                print("edit user info", error)
            }
        }
    }
    
    static func getInstagramId(completeion: @escaping (String) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else { return }
        let url = K.baseURLString + "/user/getMyIns"
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        AF.request(
            url,
            method: .get,
            headers: headers
        ).responseDecodable(of: InsResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                if let id = apiResponse.result {
                    completeion(id)
                }
            case .failure(let error):
                print("get ista id error: \(error)")
                completeion("")
            }
        }
    }
}

//curl -X 'PATCH' \
//  'http://15.164.227.179:3000/user/changeInfo' \
//  -H 'accept: application/json' \
//  -H 'Content-Type: application/json' \
//  -d '{
//  "MBTI": "INTP",
//  "is_smoking": true,
//  "is_drinking": 1,
//  "instagram_id": "wwnnss08"
//}'
