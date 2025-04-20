//
//  IdealTypeAPI.swift
//  SMU Signal
//
//  Created by 이승준 on 4/18/25.
//

import Alamofire

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
            return
        }
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Authorization": "Bearer \(accessToken)"
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
        let url = K.baseURLString + "/idleType/addIdleType"
        AF.request(
            url,
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseDecodable(of: IdealTypeAPI.self) { response in
            switch response.result {
            case .success(_):
                guard let statusCode = response.response?.statusCode else { completion(IdealTypeCode.serverError)
                    return }
                print("statusCode in addIdleType \(statusCode)")
                print("\(response.result)")
                switch statusCode {
                case 200, 201:
                    completion(.success)
                case 400:
                    completion(.missingValue)
                case 401:
                    completion(.invalidToken)
                case 403:
                    completion(.expiredToken)
                default:
                    completion(.serverError)
                }
            case .failure(let error):
                print(response.result)
                print(error)
            }
        }
    }
    
}
