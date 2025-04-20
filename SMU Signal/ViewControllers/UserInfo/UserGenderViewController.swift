//
//  TemplateViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserGenderViewController: UIViewController, UIGestureRecognizerDelegate {
    
    private let userGenderView = GenderView()
    let nextVC = UserBirthdayViewController()
    
    override func viewDidLoad() {
        self.view = userGenderView
        self.setButtonActions()
        userGenderView.configure(mainText: "성별을 알려주세요.", subText: "알려주시는 정보는 이상형에 얼마나 충족되는지\n확인하는 용도로만 사용해요.", progress: 1.0/7.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userGenderView.setButtonConstraints()
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        guard let gender = Singletone.userInfo.gender else { return }
        switch gender {
        case Gender.male.rawValue:
            userGenderView.maleButton.checked()
        case Gender.female.rawValue:
            userGenderView.femaleButton.checked()
        case Gender.other.rawValue:
            userGenderView.otherButton.checked()
        default:
            break
        }
    }
    
    private func setButtonActions() {
        userGenderView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userGenderView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
        userGenderView.maleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        userGenderView.femaleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        userGenderView.otherButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped(_ sender: GenderButton) {
        let buttons = [userGenderView.maleButton, userGenderView.femaleButton, userGenderView.otherButton]
        
        for button in buttons {
            if sender == button {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        userGenderView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        let buttons = [userGenderView.maleButton, userGenderView.femaleButton, userGenderView.otherButton]
        for button in buttons {
            if button.isChecked {
                Singletone.typeGender(button.gender!.getValue())
            }
        }
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func isNextButtonAvailable() {
        userGenderView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UINavigationController(rootViewController: UserGenderViewController())
}
