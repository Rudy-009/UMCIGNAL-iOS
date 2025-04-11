//
//  ViewController.swift
//  UMCignal
//
//  Created by 이승준 on 3/14/25.
//

import UIKit
import Alamofire

class LoginViewController: UIViewController {
    
    public let loginView = LoginView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginView
        setActions()
        hideKeyboardWhenTappedAround()
    }
    
}

extension LoginViewController {
    
    private func setActions() {
        loginView.sendVerifyCodeButton.addTarget(self, action: #selector(sendToEmail), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
}

extension LoginViewController {
    
    @objc
    private func sendToEmail() {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            "mail": loginView.emailTextField.text ?? ""
        ]
        print("mail: \(loginView.emailTextField.text ?? "")")
        AF.request(
            K.baseURLString + "/user/mailCode",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseDecodable(of: EmailCodeResponse.self) { response in
            switch response.result {
            case .success(_):
                return
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    struct EmailCodeResponse: Codable {
        let userId: String?
        let message: String
    }
    
    @objc
    private func login() {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            "mailVerification": loginView.codeTextField.text ?? ""
        ]
        
        AF.request(
            K.baseURLString + "/user/verify",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                _ = KeychainService.add(key: K.APIKey.accessToken, value: value.token)
                self.checkUserProcess()
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    struct TokenResponse: Codable {
        let message: String
        let token: String
    }
    
    private func checkUserProcess() {
        guard let accessToken = KeychainService.get(key: K.APIKey.accessToken) else { return }
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
            case .success(let value):
                if let signup = value.signUpStatus {
                    if signup {
                        if let ideal = value.idleTypeStatus {
                            if ideal {
                                print("every progress is completed")
                            } else {
                                print("ideal is not completed")
                            }
                        }
                    } else {
                        print("signup is not completed")
                    }
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    struct CheckSignUpResponse: Codable {
        let signUpStatus: Bool?
        let idleTypeStatus: Bool?
        let message: String
    }
}

import SwiftUI
#Preview {
    LoginViewController()
}
