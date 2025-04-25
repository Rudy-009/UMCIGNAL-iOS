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

enum CommonCode {
    case success
    case error
    case expired
    case missing
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
                switch statusCode {
                case 200..<300:
                    Singletone.setReRollCount(apiResponse.result!)
                    completion(.success)
                case 401, 403:
                    completion(.expired)
                case 404:
                    completion(.missing)
                default:
                    completion(.error)
                }
            case .failure(_):
                completion(.error)
            }
        }
    }
    
    static func editUserInfo(completion: @escaping (CommonCode) -> Void) {
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
                guard let statusCode = response.response?.statusCode else {
                    completion(.error)
                    return
                }
                switch statusCode {
                case 200..<300:
                    completion(.success)
                case 400..<500:
                    completion(.expired)
                case 500:
                    completion(.error)
                default:
                    completion(.error)
                }
            case .failure(_):
                completion(.error)
            }
        }
    }
    
    static func getInstagramId(completion: @escaping (String, CommonCode) -> Void) {
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
                guard let statusCode = response.response?.statusCode else {
                    completion("error", .error)
                    return
                }
                switch statusCode {
                case 200..<300:
                    if let id = apiResponse.result {
                        completion(id, .success)
                    }
                case 400..<500:
                    completion("", .expired)
                case 500:
                    completion("", .error)
                default:
                    completion("", .error)
                    return
                }
            case .failure(_):
                completion("error", .error)
            }
        }
    }
}
