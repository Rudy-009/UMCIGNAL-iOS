//
//  IdealSmokeViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class IdealSmokeViewController: UIViewController {
    
    private let idealSmokeView = SmokeView()
    let nextVC = IdealAlcoholViewController()
    
    override func viewDidLoad() {
        self.view = idealSmokeView
        self.setButtonActions()
        idealSmokeView.configure(mainText: "상대방의 흡연여부를 골라주세요.", subText: " ", progress: 2.0/5.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        idealSmokeView.setButtonConstraints()
        guard let isSmoker = Singletone.idealType.smoking_idle else { // 첫 실행이면 없음
            return }
        if isSmoker {
            idealSmokeView.smokerButton.checked()
        } else {
            idealSmokeView.nonSmokerButton.checked()
        }
    }
    
    private func setButtonActions() {
        idealSmokeView.smokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        idealSmokeView.nonSmokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        idealSmokeView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        idealSmokeView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
    }
    
    @objc
    private func handleButtonTapped(_ sender: SmokeButton) {
        let buttons = [idealSmokeView.smokerButton, idealSmokeView.nonSmokerButton]
        for button in buttons {
            if button == sender {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        idealSmokeView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        Singletone.typeSmokingIdle(idealSmokeView.smokerButton.isChecked)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func isNextButtonAvailable() {
        let buttons = [idealSmokeView.smokerButton, idealSmokeView.nonSmokerButton]
        for button in buttons {
            if button.isMarked() {
                idealSmokeView.nextButton.available()
            }
        }
    }
    
}
