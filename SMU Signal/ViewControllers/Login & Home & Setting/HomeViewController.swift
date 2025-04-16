//
//  HomeViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let homeView = HomeView()
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view = homeView
        homeView.setConstraints()
        setActions()
    }
    
    private func setActions() {
        homeView.gearButton.addTarget(self, action: #selector(goSettingVC), for: .touchUpInside)
    }
    
    @objc
    private func goSettingVC() {
        let nextVC = SettingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

#Preview {
    UINavigationController(rootViewController: HomeViewController())
}
