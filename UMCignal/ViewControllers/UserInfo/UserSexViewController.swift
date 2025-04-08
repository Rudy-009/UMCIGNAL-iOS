//
//  TemplateViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserSexViewController: UIViewController {
    
    private let userSexView = UserSexView()
    
    override func viewDidLoad() {
        self.view = userSexView
        self.setButtonActions()
    }
    
    private func setButtonActions() {
        userSexView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userSexView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let nextVC = UserBirthdayViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        userSexView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UserSexViewController()
}
