//
//  IdealAgeViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class IdealAgeViewController: UIViewController, UIGestureRecognizerDelegate {
    
    let idealAgeView = IdealAgeView()
    let nextVC = IdealSmokeViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = idealAgeView
        idealAgeView.configure(mainText: "상대방의 나이를 골라주세요.", subText: " ", progress: 1.0/5.0)
        setButtonActions()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    private func setButtonActions() {
        idealAgeView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        idealAgeView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
        idealAgeView.youngerButton.addTarget(self, action: #selector(ageButtonTapped(_:)), for: .touchUpInside)
        idealAgeView.sameButton.addTarget(self, action: #selector(ageButtonTapped(_:)), for: .touchUpInside)
        idealAgeView.olderButton.addTarget(self, action: #selector(ageButtonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func ageButtonTapped(_ sender: AgeButton) {
        let buttons = [idealAgeView.youngerButton, idealAgeView.sameButton, idealAgeView.olderButton]
        for button in buttons {
            if sender == button {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        idealAgeView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        self.dismiss(animated: false)
    }
    
    @objc
    private func pushNextVC() {
        let buttons = [idealAgeView.youngerButton, idealAgeView.sameButton, idealAgeView.olderButton]
        for button in buttons {
            if button.isMarked() {
                IdealTypeInfoSingletone.typeAgeGap(button.agePrefered!.rawValue)
            }
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func isNextButtonAvailable() {
        idealAgeView.nextButton.available()
    }
    
}


#Preview{
    UINavigationController(rootViewController: IdealAgeViewController())
}
