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
            case .success(let value):
                print("Success: \(value)")
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
        print("token: \(loginView.codeTextField.text ?? "")")
        AF.request(
            K.baseURLString + "/user/verify",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let value):
                print("Success: \(value)")
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    struct TokenResponse: Codable {
        let message: String
        let token: String
    }
    
}

import SwiftUI
#Preview {
    LoginViewController()
}
