//
//  UserMajorViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserMajorViewController: UIViewController {
    
    private let userMajorView = MajorView()
    
    override func viewDidLoad() {
        self.view = userMajorView
        self.setButtonActions()
        userMajorView.nextButton.available()
        userMajorView.configure(mainText: "주전공 학과가 어디인가요?", subText: "학과 궁합도 알려드릴게요!", progress: 6.0/7.0)
    }
    
    private func setButtonActions() {
        userMajorView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userMajorView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let nextVC = UserInstagramIDViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        userMajorView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UserMajorViewController()
}
