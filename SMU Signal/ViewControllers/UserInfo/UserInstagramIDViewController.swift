//
//  UserInstagramIDViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserInstagramIDViewController: UIViewController {
    
    private let userInstagramIDView = InstagramIDView()
    
    override func viewDidLoad() {
        self.view = userInstagramIDView
        self.setButtonActions()
        self.hideKeyboardWhenTappedAround()
        userInstagramIDView.configure(mainText: "인스타그램 아이디를 입력해주세요.", subText: "개인정보 노출을 최소화하기 위해 UMCignal은 여러분의 인스타그램 아이디 하나만 받고 있어요.", progress: 1.0)
    }
    
    private func setButtonActions() {
        userInstagramIDView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userInstagramIDView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        userInstagramIDView.idTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    @objc
    private func textFieldDidChanged() {
        userInstagramIDView.idTextField.layer.borderWidth = 2
        userInstagramIDView.idTextField.layer.borderColor = UIColor.TB.cgColor
        isNextButtonAvailable()
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        UserInfoSingletone.typeInstagramId(userInstagramIDView.idTextField.text!)
        
        print(UserInfoSingletone.shared)
    }
    
    private func isNextButtonAvailable() {
        userInstagramIDView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UserInstagramIDViewController()
}
