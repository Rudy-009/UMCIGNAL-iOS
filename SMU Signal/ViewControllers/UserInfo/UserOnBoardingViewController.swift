//
//  UserOnBoardingViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit

class UserOnBoardingViewController: UIViewController {
    
    private let onBoardingView = UserOnBoardingView()
    
    override func viewDidLoad() {
        self.view = onBoardingView
        onBoardingView.checkButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        onBoardingView.setConstraints()
    }
    
    @objc
    private func didTapNextButton() {
        let nextVC = UserGenderViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}

#Preview {
    UserOnBoardingViewController()
}
