//
//  BirthdaySelectionViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserBirthdayViewController: UIViewController {
    
    private let userBirthdayView = UserBirthdayView()
    
    override func viewDidLoad() {
        self.view = userBirthdayView
        self.setButtonActions()
    }
    
    private func setButtonActions() {
        userBirthdayView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userBirthdayView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let nextVC = UserSmokeViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        userBirthdayView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UserBirthdayViewController()
}
