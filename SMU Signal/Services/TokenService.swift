//
//  TokenService.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import Alamofire

enum TokenResult {
    case success         // 200
    case expired         // 401
    case idealNotCompleted // 403 (idleTypeStatus가 false)
    case signupNotCompleted // 403 (signUpStatus가 false)
    case error           // 500 or 기타
}

struct CheckSignUpResponse: Codable {
    let signUpStatus: Bool?
    let idleTypeStatus: Bool?
    let message: String
}

class TokenService {
    static func checkToken(completion: @escaping (TokenResult) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else {
            completion(.expired)
            return
        }
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        let url = K.baseURLString + "/operating/checkSignUp"
        AF.request(
            url,
            method: .get,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseDecodable(of: CheckSignUpResponse.self) { response in
            guard let statusCode = response.response?.statusCode else {
                completion(.error)
                return
            }
            switch statusCode {
            case 200:
                if let value = response.value {
                    if let signup = value.signUpStatus, signup {
                        if let ideal = value.idleTypeStatus, ideal {
                            completion(.success)
                        } else {
                            completion(.idealNotCompleted)
                        }
                    } else {
                        completion(.signupNotCompleted)
                    }
                } else {
                    completion(.error)
                }
            case 401, 404:
                completion(.expired)
            case 403:
                if let value = response.value {
                    if let signup = value.signUpStatus, !signup {
                        completion(.signupNotCompleted)
                    } else if let ideal = value.idleTypeStatus, !ideal {
                        completion(.idealNotCompleted)
                    } else {
                        completion(.error)
                    }
                } else {
                    completion(.error)
                }
            case 500:
                completion(.error)
            default:
                completion(.error)
            }
        }
    }
}
