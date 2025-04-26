//
//  IdealMajorViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/18/25.
//

import UIKit
class IdealMajorViewController: UIViewController {
    
    private let idealMajorView = IdealMajorView()
    
    override func viewDidLoad() {
        self.view = idealMajorView
        self.setButtonActions()
        idealMajorView.configure(mainText: "상대방이 나와 같은 학과라면", subText: " ", progress: 1.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        idealMajorView.setButtonConstraints()
        guard let majorBool = Singletone.idealType.sameMajor else { // 첫 실행이면 없음
            return }
        if majorBool == 1 {
            idealMajorView.yesButton.checked()
        } else {
            idealMajorView.noButton.checked()
        }

    }
    
    private func setButtonActions() {
        idealMajorView.yesButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        idealMajorView.noButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        idealMajorView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        idealMajorView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
    }
    
    @objc
    private func handleButtonTapped(_ sender: SmokeButton) {
        let buttons = [idealMajorView.yesButton, idealMajorView.noButton]
        for button in buttons {
            if button == sender {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        idealMajorView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        Singletone.typeMajorIdle(idealMajorView.yesButton.isChecked ? 1 : 0)
        APIService.addIdeal { result in
            switch result {
            case .success:
                RootViewControllerService.toMatchViewController()
                Singletone.removeIdealTypeInfo()
            case .missingValue:
                RootViewControllerService.toIdealViewController()
            case .invalidToken, .expiredToken:
                RootViewControllerService.toLoginController()
            case .serverError:
                self.persentNetworkErrorAlert()
            }
        }
    }
    
    private func isNextButtonAvailable() {
        let buttons = [idealMajorView.yesButton, idealMajorView.noButton]
        for button in buttons {
            if button.isMarked() {
                idealMajorView.nextButton.available()
            }
        }
    }
    
}
