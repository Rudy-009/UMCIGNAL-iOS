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
        
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
//        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
//    
//    @objc private func keyboardWillShow(_ notification: Notification) {
//        guard let userInfo = notification.userInfo,
//              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
//        let keyboardHeight = keyboardFrame.cgRectValue.height
//        // codeTextField가 firstResponder일 때만 동작
//        if loginView.codeTextField.isFirstResponder {
//            loginView.keyBoardWillAppear(keyboardHeight: keyboardHeight)
//        }
//    }
//
//    @objc private func keyboardWillHide(_ notification: Notification) {
//        loginView.keyBoardWillDisappear()
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
        let headers: HTTPHeaders = [
            "accept": "application/json",
            "Content-Type": "application/json"
        ]
        let parameters: [String: Any] = [
            "mail": loginView.emailTextField.text! + "@sangmyung.kr"
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
            case .success(let apiResponse):
                let code = response.response!.statusCode
                print("code: \(code)")
                var message = apiResponse.message
                switch code {
                case 200:
                    self.loginView.sendVerifyCodeButton.configure(labelText: "전송 완료")
                    self.loginView.sendVerifyCodeButton.unavailable()
                    self.loginView.codeSentMode()
                case 201 :
                    self.loginView.sendVerifyCodeButton.configure(labelText: "전송 완료")
                    self.loginView.sendVerifyCodeButton.unavailable()
                    self.loginView.codeSentMode()
                    message += "\n스펨메일함도 확인해주세요."
                case 400:
                    break
                case 500:
                    break
                default:
                    break
                }
                self.loginView.emailSubLabel.text = message
                self.loginView.emailSubLabel.isHidden = false
                return
            case .failure(let error):
                print("Error: \(error)")
            }
        }
    }
    
    struct EmailCodeResponse: Codable {
        let userId: Int?
        let message: String
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
                var message = ""
                switch code {
                case 200:
                    print("로그인 성공")
                    _ = KeychainService.add(key: K.APIKey.accessToken, value: apiResponse.token!)
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
                            print("알 수 없는 오류가 발생했습니다.")
                        }
                    }
                case 400, 401, 408, 500:
                    print(message)
                    message = apiResponse.message
                default:
                    break
                }
                self.loginView.codeSubLabel.text = message
                self.loginView.codeSubLabel.isHidden = false
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
