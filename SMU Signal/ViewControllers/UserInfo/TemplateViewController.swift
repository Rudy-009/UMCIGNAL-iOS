//
//  TemplateViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class TemplateViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let templateView = TemplateView()
    let nextVC = TemplateViewController()
    
    override func viewDidLoad() {
        self.view = templateView
        self.setButtonActions()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setButtonActions() {
        templateView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        templateView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func isNextButtonAvailable() {
        templateView.nextButton.available()
    }
    
}
