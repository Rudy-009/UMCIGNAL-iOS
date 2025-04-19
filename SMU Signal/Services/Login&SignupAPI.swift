//
//  TokenService.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import Alamofire

enum TokenCode {
    case success            // 200
    case expired            // 401
    case idealNotCompleted  // 403 (idleTypeStatus가 false)
    case signupNotCompleted // 403 (signUpStatus가 false)
    case error              // 500 or 기타
}

struct CheckSignUpResponse: Codable {
    let signUpStatus: Bool?
    let idleTypeStatus: Bool?
    let message: String
}

enum SignupCode: Int {
    case success = 201 // 성공
    case missing = 400 // 입력값 누락
    case expired = 401 // 토큰 만료
    case error   = 500 // 서버 에러
}

struct SignUpResponse: Codable {
    let message: String
    let data: UserInfo?
    let missingFields: [String]?
}

enum LogoutCode: Int {
    case success = 200
    case success1 = 201
    case error   = 500
    case expired = 401
    case missing = 404
}

struct LogoutOrSignoutResponse: Codable {
    let message: String
}

class APIService {
    static func checkToken(completion: @escaping (TokenCode) -> Void) {
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
                completion(.success)
            case 401, 404:
                completion(.expired)
            case 403:
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
            case 500:
                completion(.error)
            default:
                completion(.error)
            }
        }
    }
    
    static func signup(completion: @escaping (SignupCode) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else {
            completion(.expired)
            return
        }
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        let userInfo = UserInfoSingletone.shared
        let parameters: [String: Any] = [
            "gender":  userInfo.gender!,
            "name": userInfo.name ?? String(),
            "student_major": userInfo.student_major!,
            "MBTI": userInfo.MBTI!,
            "is_smoking": userInfo.is_smoking!,
            "is_drinking": userInfo.is_drinking!,
            "instagram_id": userInfo.instagram_id!,
            "age": userInfo.age!
        ]
        let url = K.baseURLString + "/user/signup"
        AF.request(
            url,
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers,
        ).responseDecodable(of: CheckSignUpResponse.self) { response in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    completion(.error)
                    return
                }
                print("status code in signup: \(statusCode)")
                switch statusCode {
                case SignupCode.success.rawValue:
                    completion(.success)
                case SignupCode.expired.rawValue:
                    completion(.expired)
                case SignupCode.missing.rawValue:
                    completion(.missing)
                case SignupCode.error.rawValue:
                    completion(.error)
                default:
                    completion(.error)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    static func out(_  action: String) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else {
            return
        }
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
        ]
        let parameters: [String: Any] = [:]
        let url = K.baseURLString + "/user/\(action)"
        AF.request(
            url,
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers,
        ).responseDecodable(of: LogoutOrSignoutResponse.self) { response in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else {
                    return
                }
                switch statusCode {
                case 200, 201, 401, 404:
                    RootViewControllerService.toLoginController()
                    _ = KeychainService.delete(key: K.APIKey.accessToken)
                case 500:
                    break
                default:
                    break
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
}
