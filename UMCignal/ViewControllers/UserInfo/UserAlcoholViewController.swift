//
//  UserAlcoholViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserAlcoholViewController: UIViewController {
    
    private let userAlcoholView = UserAlcoholView()
    
    override func viewDidLoad() {
        self.view = userAlcoholView
        self.setButtonActions()
    }
    
    private func setButtonActions() {
        userAlcoholView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userAlcoholView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let nextVC = UserMBTIViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        userAlcoholView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UserAlcoholViewController()
}
