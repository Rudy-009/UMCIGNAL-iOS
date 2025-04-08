//
//  SmokeSelectionViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserSmokeViewController: UIViewController {
    
    private let userSmokeView = UserSmokeView()
    
    override func viewDidLoad() {
        self.view = userSmokeView
        self.setButtonActions()
    }
    
    private func setButtonActions() {
        userSmokeView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userSmokeView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let nextVC = UserAlcoholViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        userSmokeView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UserSmokeViewController()
}

