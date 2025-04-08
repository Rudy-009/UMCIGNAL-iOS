//
//  TemplateViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class TemplateViewController: UIViewController {
    
    private let templateView = TemplateView()
    
    override func viewDidLoad() {
        self.view = templateView
        self.setButtonActions()
    }
    
    private func setButtonActions() {
        templateView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        templateView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let nextVC = TemplateViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        templateView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    TemplateViewController()
}
