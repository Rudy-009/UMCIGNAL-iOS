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
        hideKeyboardWhenTappedAround()
        setActions()
        loginView.emailTextField.delegate = self
        loginView.codeTextField.delegate = self
    }
    
}

// MARK: 버튼 동작 및 텍스트 필드 동작
extension LoginViewController: UITextFieldDelegate {
    
    private func setActions() {
        loginView.sendVerifyCodeButton.addTarget(self, action: #selector(sendToEmail), for: .touchUpInside)
        loginView.loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        loginView.emailTextField.addTarget(self, action: #selector(editingStarted(_ :)), for: .editingDidBegin)
        loginView.codeTextField.addTarget(self, action: #selector(editingStarted(_ :)), for: .editingDidBegin)
        loginView.emailTextField.addTarget(self, action: #selector(emailTextFieldDidChange(_ :)), for: .editingChanged)
        loginView.codeTextField.addTarget(self, action: #selector(codeTextFieldDidChange(_ :)), for: .editingChanged)
        loginView.emailTextField.addTarget(self, action: #selector(nonEditingMode(_ :)), for: .editingDidEnd)
        loginView.codeTextField.addTarget(self, action: #selector(nonEditingMode(_ :)), for: .editingDidEnd)
    }
    
    @objc
    private func emailTextFieldDidChange(_ sender: UITextField) {
        let text = loginView.emailTextField.text ?? ""
        if let _ = Int(text) {
            if text.count == 9 {
                loginView.sendVerifyCodeButton.available()
            } else {
                loginView.sendVerifyCodeButton.unavailable()
            }
        } else {
            loginView.sendVerifyCodeButton.unavailable()
            // 숫자가 아닌 텍스트가 입력된 경우
        }
    }
    
    @objc
    private func codeTextFieldDidChange(_ sender: UITextField) {
        sender.layer.borderColor = UIColor.red400.cgColor
        let text = loginView.codeTextField.text ?? ""
        if let _ = Int(text) {
            if text.count == 6 {
                sender.layer.borderColor = UIColor.TB.cgColor
                loginView.loginButton.available()
            } else {
                loginView.loginButton.unavailable()
            }
        } else {
            loginView.loginButton.unavailable()
            // 숫자가 아닌 텍스트가 입력된 경우
        }
    }
    
    @objc
    private func editingStarted(_ sender: UITextField) {
        if sender == loginView.emailTextField {
            sender.layer.borderColor = UIColor.TB.cgColor
        } else if sender == loginView.codeTextField {
            sender.layer.borderColor = UIColor.red400.cgColor
        }
    }
    
    @objc
    private func nonEditingMode(_ sender: UITextField) {
        sender.layer.borderColor = UIColor.gray200.cgColor
    }
    
    // 글자 수 제한
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        var maxLength = 0
        if textField == loginView.emailTextField {
            maxLength = 9
        } else if textField == loginView.codeTextField {
            maxLength = 6
        }
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
    // Return 대응인데 Return이 없음...
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == loginView.emailTextField && loginView.sendVerifyCodeButton.isEnabled {
            sendToEmail()
        } else if textField == loginView.codeTextField && loginView.loginButton.isEnabled {
            login()
        } else {
            return false
        }
        return true
    }
    
}

// MARK: API 연결
extension LoginViewController {
    
    @objc
    private func sendToEmail() {
        APIService.sendToEmail(number: loginView.emailTextField.text!) { code in
            switch code {
            case .success:
                self.loginView.sendVerifyCodeButton.configure(labelText: "전송 완료")
                self.loginView.sendVerifyCodeButton.unavailable()
                self.loginView.codeSentMode()
            case .error:
                self.persentNetwoekErrorAlert()
            case .Unavailable:
                self.loginView.emailIsNotValidMode()
            case .missing:
                self.loginView.emailIsNotValidMode()
            }
        }
    }
    
    
    
    @objc
    private func login() {
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            "mailVerification": loginView.codeTextField.text!
        ]
        AF.request(
            K.baseURLString + "/user/verify",
            method: .post,
            parameters: parameters,
            encoding: JSONEncoding.default,
            headers: headers
        ).responseDecodable(of: TokenResponse.self) { response in
            switch response.result {
            case .success(let apiResponse):
                let code = response.response!.statusCode
                switch code {
                case 200:
                    if KeychainService.add(key: K.APIKey.accessToken, value: apiResponse.token!) {
                        APIService.checkToken { result in
                            switch result {
                            case .success: // home
                                RootViewControllerService.toHomeViewController()
                            case .expired: // login
                                RootViewControllerService.toLoginController()
                            case .idealNotCompleted: // ideal
                                RootViewControllerService.toIdealViewController()
                            case .signupNotCompleted: // signup
                                RootViewControllerService.toSignUpViewController()
                            case .error: // ??
                                self.persentNetwoekErrorAlert()
                            }
                        }
                    }
                case 400..<409:
                    self.loginView.codeIsNotValidMode()
                case 500:
                    self.persentNetwoekErrorAlert()
                default:
                    self.persentNetwoekErrorAlert()
                }
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    struct TokenResponse: Codable {
        let message: String
        let token: String?
    }
}

import SwiftUI
#Preview {
    LoginViewController()
}
