//
//  SmokeSelectionViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserSmokeViewController: UIViewController {
    
    private let userSmokeView = SmokeView()
    
    override func viewDidLoad() {
        self.view = userSmokeView
        self.setButtonActions()
        userSmokeView.configure(mainText: "흡연 하시나요?", subText: "서로 흡연에 대한 생각이 같은 분들과 \n매칭해드릴게요.", progress: 3.0/7.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userSmokeView.setButtonConstraints()
    }
    
    private func setButtonActions() {
        userSmokeView.smokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        userSmokeView.nonSmokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        userSmokeView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userSmokeView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func handleButtonTapped(_ sender: SmokeButton) {
        let buttons = [userSmokeView.smokerButton, userSmokeView.nonSmokerButton]
        for button in buttons {
            if button == sender {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        userSmokeView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let nextVC = UserAlcoholViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        let buttons = [userSmokeView.smokerButton, userSmokeView.nonSmokerButton]
        for button in buttons {
            if button.isMarked() {
                userSmokeView.nextButton.available()
            }
        }
    }
    
}

