//
//  EditSmokingViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/21/25.
//

import UIKit
import Combine

class EditSmokingViewController: UIViewController {
    
    private let editSmokeView = SmokeView()
    let nextVC = EditAlcoholViewController();
    
    override func viewDidLoad() {
        self.view = editSmokeView
        self.setButtonActions()
        editSmokeView.configure(mainText: "흡연 하시나요?", subText: "서로 흡연에 대한 생각이 같은 분들과 \n매칭해드릴게요.", progress: 0.25)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editSmokeView.setButtonConstraints()
        guard let isSmoker = Singletone.editUserInfo.is_smoking else { // 첫 실행이면 없음
            return }
        if isSmoker {
            editSmokeView.smokerButton.checked()
        } else {
            editSmokeView.nonSmokerButton.checked()
        }
    }
    
    private func setButtonActions() {
        editSmokeView.smokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        editSmokeView.nonSmokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        editSmokeView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        editSmokeView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
    }
    
    @objc
    private func handleButtonTapped(_ sender: SmokeButton) {
        let buttons = [editSmokeView.smokerButton, editSmokeView.nonSmokerButton]
        for button in buttons {
            if button == sender {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        editSmokeView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        Singletone.editSmoking(editSmokeView.smokerButton.isChecked)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func isNextButtonAvailable() {
        let buttons = [editSmokeView.smokerButton, editSmokeView.nonSmokerButton]
        for button in buttons {
            if button.isMarked() {
                editSmokeView.nextButton.available()
            }
        }
    }
}
