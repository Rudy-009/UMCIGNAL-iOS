//
//  UserAlcoholViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserAlcoholViewController: UIViewController {
    
    private let userAlcoholView = AlcoholView()
    let nextVC = UserMBTIViewController()
    
    override func viewDidLoad() {
        self.view = userAlcoholView
        self.setButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userAlcoholView.setButtonConstraints()
        userAlcoholView.configure(mainText: "술 좋아하시나요?", subText: "궁합에서 음주량도 엄청 중요해요.\n여러분의 주량에 대해 알려주세요.", progress: 4.0/7.0)
        guard let alcoholCapability = Singletone.userInfo.is_drinking else { return }
        switch alcoholCapability {
        case 1:
            userAlcoholView.aGlassButton.checked()
        case 2:
            userAlcoholView.aBottleButton.checked()
        case 3:
            userAlcoholView.bottlesButton.checked()
        default:
            break
        }
    }
    
    private func setButtonActions() {
        userAlcoholView.aGlassButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        userAlcoholView.aBottleButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        userAlcoholView.bottlesButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        userAlcoholView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userAlcoholView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
    }
    
    @objc
    private func selectAlcohol(_ sender: AlcoholCapabilityButton) {
        let buttons = [userAlcoholView.aGlassButton, userAlcoholView.aBottleButton, userAlcoholView.bottlesButton]
        
        for button in buttons {
            if sender == button {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        userAlcoholView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        let buttons = [userAlcoholView.aGlassButton, userAlcoholView.aBottleButton, userAlcoholView.bottlesButton]
        for button in buttons {
            if button.isChecked {
                Singletone.typeIsDrinking(button.alcohol!.toResponse())
            }
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
}
