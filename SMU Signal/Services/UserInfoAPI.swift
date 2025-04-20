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

extension APIService {
    
    static func getRerollCount(completion: @escaping (RerollCountCode) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else {
            completion(.expired)
            return
        }
        print(accessToken)
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
    
}
