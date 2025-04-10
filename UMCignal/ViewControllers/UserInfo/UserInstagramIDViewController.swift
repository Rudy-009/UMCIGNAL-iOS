//
//  UserInstagramIDViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserInstagramIDViewController: UIViewController {
    
    private let userInstagramIDView = UserInstagramIDView()
    
    override func viewDidLoad() {
        self.view = userInstagramIDView
        self.setButtonActions()
        self.hideKeyboardWhenTappedAround()
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
        
        let nextVC = UserSexViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        userInstagramIDView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UserInstagramIDViewController()
}
