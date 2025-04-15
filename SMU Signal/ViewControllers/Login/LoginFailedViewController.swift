//
//  LoginFailedViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class LoginFailedViewController: UIViewController {
    
    private let loginFailedView = LoginFailedView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = loginFailedView
        loginFailedView.loginButton.addTarget(self, action: #selector(pushLoginVC), for: .touchUpInside)
        
    }
    
    @objc private func pushLoginVC() {
        let loginVC = LoginViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        present(loginVC, animated: false)
    }

}

#Preview {
    LoginFailedViewController()
}
