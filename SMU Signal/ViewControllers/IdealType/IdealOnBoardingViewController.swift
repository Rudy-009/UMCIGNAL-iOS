//
//  IdealOnBoardingViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit

class IdealOnBoardingViewController: UIViewController {
    
    private let onBoardingView = IdealOnBoardingView()
    
    override func viewDidLoad() {
        self.view = onBoardingView
        onBoardingView.checkButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        onBoardingView.setConstraints()
    }
    
    @objc
    private func didTapNextButton() {
        let nextVC = IdealAgeViewController()
        self.navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
