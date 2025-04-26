//
//  UserInstagramIDViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit
import WebKit

class UserInstagramIDViewController: UIViewController, UITextFieldDelegate {
    
    private let userInstagramIDView = InstagramIDView()
    
    override func viewDidLoad() {
        self.view = userInstagramIDView
        self.setButtonActions()
        self.hideKeyboardWhenTappedAround()
        self.userInstagramIDView.idTextField.delegate = self
        self.userInstagramIDView.idTextField.becomeFirstResponder()
        userInstagramIDView.configure(mainText: "인스타그램 아이디를 입력해주세요.", subText: "입력하신 인스타그램 아이디는 매칭 및 서비스 제공을 위해 사용되며, 개인정보처리방침에 동의하시는 경우 아래 체크박스를 눌러주세요.", progress: 1.0)
        userInstagramIDView.signUpMode()
    }
    
    private func setButtonActions() {
        userInstagramIDView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userInstagramIDView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        userInstagramIDView.idTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
        userInstagramIDView.privacyPolicyButton.addTarget(self, action: #selector(showPrivacyPolicy), for: .touchUpInside)
        userInstagramIDView.checkbox.addTarget(self, action: #selector(checkPrivacyPolicy), for: .touchUpInside)
    }
    
    @objc
    private func textFieldDidChanged() {
        if userInstagramIDView.idTextField.text! != "" && userInstagramIDView.checkbox.isMarked() {
            userInstagramIDView.availableMode()
        } else {
            userInstagramIDView.defaultMode()
        }
    }
    
    @objc
    private func checkPrivacyPolicy() {
        if userInstagramIDView.checkbox.isMarked() {
            userInstagramIDView.checkbox.notChecked()
        } else {
            userInstagramIDView.checkbox.checked()
        }
        
        if userInstagramIDView.idTextField.text! != "" && userInstagramIDView.checkbox.isMarked() {
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
    
    @objc
    private func showPrivacyPolicy() {
        if let url = URL(string: "https://makeus-challenge.notion.site/UMCignal-1bcb57f4596b8006b1a3c4cdf165d5e1") {
            let modalVC = ModalViewController()
            modalVC.url = url
            modalVC.modalPresentationStyle = .pageSheet
            self.present(modalVC, animated: true, completion: nil)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        postUserInfo()
        return true
    }
    
    private func postUserInfo() {
        Singletone.typeInstagramId(userInstagramIDView.idTextField.text!)
        APIService.signup { result in
            switch result {
            case .success:
                RootViewControllerService.toIdealViewController()
            case .expired, .exception:
                RootViewControllerService.toLoginController()
            case .missing:
                RootViewControllerService.toSignUpViewController()
            case .error:
                self.persentNetworkErrorAlert()
                return
            }
        }
    }
}

