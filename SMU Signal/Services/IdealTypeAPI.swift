//
//  IdealTypeAPI.swift
//  SMU Signal
//
//  Created by 이승준 on 4/18/25.
//

import Alamofire
import Foundation

struct IdealTypeAPI: Codable {
    let message: String?
} // 정보 없음, Code (정수)로 판단

// 200 : 이상형 정보가 추가되었습니다.
// 400 : 필수 입력값이 누락되었습니다.
// 401 : 토큰이 없거나 로그인되지 않음.
// 403 : 토큰이 유효하지 않음.
// 500 : 서버 에러

enum IdealTypeCode: Int {
    case success = 201
    case missingValue = 400
    case invalidToken = 401
    case expiredToken = 403
    case serverError = 500
}

extension APIService {
    
    static func addIdeal(completion: @escaping (IdealTypeCode) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else {
            completion(.invalidToken)
            return
        }
        
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)",
            "Content-Type": "application/json"
        ]
        let ideal = Singletone.idealType
        let parameters: [String: Any] = [
            "idle_MBTI": ideal.idle_MBTI!,
            "age_gap": ideal.age_gap!,
            "smoking_idle": ideal.smoking_idle!,
            "drinking_idle": ideal.drinking_idle!,
            "major_idle": ["컴퓨터과학과"],
            "sameMajor": ideal.sameMajor!
        ]
        
        // 먼저 checkToken을 호출하여 상태를 확인한 후 메소드와 엔드포인트를 결정하고 요청을 보냄
        checkToken { token in
            var httpMethod: HTTPMethod = .post
            var endpoint: String = "addIdleType"  // 기본 엔드포인트 (POST)
            
            switch token {
            case .success:
                httpMethod = .patch
                endpoint = "fixIdleType"  // PATCH용 엔드포인트
            case .expired:
                completion(.expiredToken)
                return
            case .signupNotCompleted:
                completion(.invalidToken)
                return
            case .error:
                completion(.serverError)
                return
            case .idealNotCompleted:
                httpMethod = .post
                endpoint = "addIdleType"  // POST용 엔드포인트
            }
            
            let url = K.baseURLString + "/idleType/" + endpoint
            
            print("HTTP Method for addIdeal: \(httpMethod), Endpoint: \(endpoint)")
            
            AF.request(
                url,
                method: httpMethod,
                parameters: parameters,
                encoding: JSONEncoding.default,
                headers: headers
            ).response { response in
                // 먼저 원시 응답 데이터 확인
                if let data = response.data, let responseString = String(data: data, encoding: .utf8) {
                    print("Raw API Response: \(responseString)")
                }
                
                // 상태 코드 확인
                if let statusCode = response.response?.statusCode {
                    print("Status Code: \(statusCode)")
                }
                
                // 이제 JSON 디코딩 시도
                if let data = response.data {
                    do {
                        let apiResponse = try JSONDecoder().decode(IdealTypeAPI.self, from: data)
                        print("성공적으로 디코딩된 응답: \(apiResponse)")
                        
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 200, 201:
                                completion(.success)
                            case 400:
                                completion(.missingValue)
                            case 401:
                                print(103)
                                completion(.invalidToken)
                            case 403:
                                completion(.expiredToken)
                            default:
                                completion(.serverError)
                            }
                        } else {
                            completion(.serverError)
                        }
                    } catch {
                        if let statusCode = response.response?.statusCode {
                            switch statusCode {
                            case 200, 201:
                                completion(.success)
                            case 400:
                                completion(.missingValue)
                            case 401:
                                print(104)
                                completion(.invalidToken)
                            case 403:
                                completion(.expiredToken)
                            default:
                                completion(.serverError)
                            }
                        } else {
                            completion(.serverError)
                        }
                    }
                } else {
                    completion(.serverError)
                }
            }
        }
    }
    
}
