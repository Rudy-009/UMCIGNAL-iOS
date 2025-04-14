//
//  TemplateViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserGenderViewController: UIViewController {
    
    private let userGenderView = GenderView()
    
    override func viewDidLoad() {
        self.view = userGenderView
        self.setButtonActions()
        userGenderView.configure(mainText: "성별을 알려주세요.", subText: "알려주시는 정보는 이상형에 얼마나 충족되는지\n확인하는 용도로만 사용해요.", progress: 1.0/7.0)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userGenderView.setButtonConstraints()
    }
    
    private func setButtonActions() {
        userGenderView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userGenderView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        userGenderView.maleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        userGenderView.femaleButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        userGenderView.otherButton.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc
    private func buttonTapped(_ sender: UIButton) {
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
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let buttons = [userGenderView.maleButton, userGenderView.femaleButton, userGenderView.otherButton]
        for button in buttons {
            if button.isChecked {
                UserInfoSingletone.typeGender(button.gender!.getValue())
            }
        }
        
        let nextVC = UserBirthdayViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        userGenderView.nextButton.available()
    }
    
}


import SwiftUI
#Preview {
    UserGenderViewController()
}
