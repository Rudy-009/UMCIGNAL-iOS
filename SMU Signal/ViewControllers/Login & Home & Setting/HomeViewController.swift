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
        self.view = homeView
        setActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeView.setConstraints()
        homeView.setUI()
        setUI()
    }
    
    private func setActions() {
        homeView.gearButton.addTarget(self, action: #selector(goSettingVC), for: .touchUpInside)
        homeView.resetIdealType.addTarget(self, action: #selector(goIdealType), for: .touchUpInside)
    }
    
    private func setUI() {
        // 1. 유저의 이름
        
        // 2. 리롤 횟수
        APIService.getRerollCount { code in
            switch code {
            case .success:
                self.homeView.rerollCountLabel.text = String(Singletone.getReRollCount())
            case .expired, .missing, .error:
                RootViewControllerService.toLoginController()
            }
        }
        // 3. 사용자의 코드
    }
    
    @objc
    private func goIdealType() {
        RootViewControllerService.toIdealViewController()
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
