//
//  IdealTypeAPI.swift
//  SMU Signal
//
//  Created by 이승준 on 4/18/25.
//

import Alamofire

struct IdealTypeAPI: Codable {}

extension APIService {
    
    static func addIdeal(completion: @escaping (Int) -> Void) {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else {
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
        ).responseDecodable(of: IdealTypeAPI.self) { response in
            
        }
    }
    
}
