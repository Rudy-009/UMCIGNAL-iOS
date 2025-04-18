//
//  IdealSmokeViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class IdealSmokeViewController: UIViewController {
    
    private let userSmokeView = SmokeView()
    let nextVC = IdealAlcoholViewController()
    
    override func viewDidLoad() {
        self.view = userSmokeView
        self.setButtonActions()
        userSmokeView.configure(mainText: "상대방의 흡연여부를 골라주세요.", subText: " ", progress: 2.0/5.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userSmokeView.setButtonConstraints()
        guard let isSmoker = IdealTypeInfoSingletone.shared.smoking_idle else { // 첫 실행이면 없음
            return }
        if isSmoker {
            userSmokeView.smokerButton.checked()
        } else {
            userSmokeView.nonSmokerButton.checked()
        }
    }
    
    private func setButtonActions() {
        userSmokeView.smokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        userSmokeView.nonSmokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        userSmokeView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userSmokeView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
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
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        IdealTypeInfoSingletone.typeSmokingIdle(userSmokeView.smokerButton.isChecked)
        navigationController?.pushViewController(nextVC, animated: true)
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
