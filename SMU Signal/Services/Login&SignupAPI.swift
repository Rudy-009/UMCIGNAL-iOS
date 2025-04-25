//
//  TokenService.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import Alamofire
import Foundation

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
    case success = 200
    case success2 = 201 // 성공
    case missing = 400 // 입력값 누락
    case expired = 401 // 토큰 만료
    case exception = 404
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
            switch response.result {
            case .success(let apiResponse):
                guard let statusCode = response.response?.statusCode else {
                    completion(.error)
                    return
                }
                switch statusCode {
                case 200:
                    completion(.success)
                case 400:
                    print(apiResponse)
                    if apiResponse.signUpStatus == false {
                        completion(.signupNotCompleted)
                    } else {
                        if apiResponse.idleTypeStatus == false {
                            completion(.idealNotCompleted)
                        }
                    }
                    completion(.signupNotCompleted)
                case 401, 403, 404:
                    completion(.expired)
                case 500:
                    completion(.error)
                default:
                    completion(.error)
                }
            case .failure(let error):
                print("operation error", error)
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
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        let userInfo = Singletone.userInfo
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
        
        // checkToken을 호출하여 상태에 따라 HTTP 메소드 결정
        checkToken { token in
            var httpMethod: HTTPMethod = .post
            
            switch token {
            case .success:
                httpMethod = .patch
            case .expired:
                completion(.expired)
                return
            case .signupNotCompleted:
                httpMethod = .post
            case .idealNotCompleted:
                httpMethod = .patch
            case .error:
                completion(.error)
                return
            }
            
            print("HTTP Method for signup: \(httpMethod)")
            
            AF.request(
                url,
                method: httpMethod,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            ).response { response in
                // 먼저 원시 응답 데이터 확인
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("Raw API Response (signup): \(responseString)")
                }
                
                // 상태 코드 확인
                if let statusCode = response.response?.statusCode {
                    print("Status Code (signup): \(statusCode)")
                }
                
                // 이제 JSON 디코딩 시도
                if let data = response.data {
                    do {
                        let apiResponse = try JSONDecoder().decode(CheckSignUpResponse.self, from: data)
                        print("성공적으로 디코딩된 응답 (signup): \(apiResponse)")
                        
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case SignupCode.success.rawValue, SignupCode.success2.rawValue:
                                completion(.success)
                                APIService.checkToken { token in
                                    switch token {
                                    case .success, .idealNotCompleted:
                                        RootViewControllerService.toIdealViewController()
                                    case .expired:
                                        RootViewControllerService.toLoginController()
                                    case .signupNotCompleted:
                                        RootViewControllerService.toSignUpViewController()
                                    case .error:
                                        break
                                    }
                                }
                            case SignupCode.expired.rawValue:
                                completion(.expired)
                            case SignupCode.missing.rawValue:
                                completion(.missing)
                            case SignupCode.error.rawValue:
                                completion(.error)
                            default:
                                completion(.error)
                            }
                        } else {
                            completion(.error)
                        }
                    } catch {
                        print("JSON 디코딩 오류 (signup): \(error)")
                        
                        // 백업 데이터 처리 - 상태 코드만으로 판단
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case SignupCode.success.rawValue, SignupCode.success2.rawValue:
                                completion(.success)
                                APIService.checkToken { token in
                                    switch token {
                                    case .success, .idealNotCompleted:
                                        RootViewControllerService.toIdealViewController()
                                    case .expired:
                                        RootViewControllerService.toLoginController()
                                    case .signupNotCompleted:
                                        RootViewControllerService.toSignUpViewController()
                                    case .error:
                                        break
                                    }
                                }
                            case SignupCode.expired.rawValue:
                                completion(.expired)
                            case SignupCode.missing.rawValue:
                                completion(.missing)
                            case SignupCode.error.rawValue:
                                completion(.error)
                            default:
                                completion(.error)
                            }
                        } else {
                            completion(.error)
                        }
                    }
                } else {
                    print("응답 데이터가 없습니다 (signup).")
                    completion(.error)
                }
            }
        }
    }
    
    static func out(_  action: String) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else {
            return
        }
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [:]
        let url = K.baseURLString + "/user/\(action)"
        AF.request(
            url,
            method: .patch,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).response { response in
            // 먼저 원시 응답 데이터 확인
            if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                print("Raw API Response (out): \(responseString)")
            }
            
            // 상태 코드 확인
            if let statusCode = response.response?.statusCode {
                print("Status Code (out): \(statusCode)")
                
                switch statusCode {
                case 200, 201, 401, 404:
                    _ = KeychainService.delete(key: K.APIKey.accessToken)
                    Singletone.clearUserInfo()
                    RootViewControllerService.toLoginController()
                case 500:
                    print("서버 오류 (out)")
                    break
                default:
                    print("알 수 없는 상태 코드 (out): \(statusCode)")
                    break
                }
            } else {
                print("상태 코드 없음 (out)")
            }
            
            // 오류 확인
            if let error = response.error {
                print("API 요청 오류 (out): \(error)")
            }
        }
    }
    
}
