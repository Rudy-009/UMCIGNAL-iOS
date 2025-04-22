//
//  UserInstagramIDViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserInstagramIDViewController: UIViewController, UITextFieldDelegate {
    
    private let userInstagramIDView = InstagramIDView()
    
    override func viewDidLoad() {
        self.view = userInstagramIDView
        self.setButtonActions()
        self.hideKeyboardWhenTappedAround()
        self.userInstagramIDView.idTextField.delegate = self
        self.userInstagramIDView.idTextField.becomeFirstResponder()
        userInstagramIDView.configure(mainText: "인스타그램 아이디를 입력해주세요.", subText: "개인정보 노출을 최소화하기 위해 UMCignal은 여러분의 인스타그램 아이디 하나만 받고 있어요.", progress: 1.0)        
    }
    
    private func setButtonActions() {
        userInstagramIDView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userInstagramIDView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        userInstagramIDView.idTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    @objc
    private func textFieldDidChanged() {
        if userInstagramIDView.idTextField.text! != "" {
            userInstagramIDView.availableMode()
        } else {
            userInstagramIDView.defaultMode()
        }
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextVC() {
        postUserInfo()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        postUserInfo()
        return true
    }
    
    private func postUserInfo() {
        Singletone.typeInstagramId(userInstagramIDView.idTextField.text!)
        APIService.signup { result in
            switch result {
            case .success, .success2:
                RootViewControllerService.toIdealViewController()
            case .expired:
                RootViewControllerService.toLoginController()
            case .missing:
                RootViewControllerService.toSignUpViewController()
            case .error:
                print("error")
                return
            }
        }
    }
}

