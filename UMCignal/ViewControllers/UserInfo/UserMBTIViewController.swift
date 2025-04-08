//
//  UserMBTIViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserMBTIViewController: UIViewController {
    
    private let userMBTIView = UserMBTIView()
    
    override func viewDidLoad() {
        self.view = userMBTIView
        self.setButtonActions()
    }
    
    private func setButtonActions() {
        userMBTIView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userMBTIView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let nextVC = UserMajorViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        userMBTIView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UserMBTIViewController()
}
