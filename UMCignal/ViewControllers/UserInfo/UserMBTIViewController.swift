//
//  UserMBTIViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserMBTIViewController: UIViewController {
    
    private let userMBTIView = UserMBTIView()
    
    override func viewDidLoad() {
        self.view = userMBTIView
        self.setButtonActions()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        userMBTIView.setButtonConstraints()
    }
    
    private func setButtonActions() {
        userMBTIView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userMBTIView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        let buttons: [MBTIButton] = [userMBTIView.mbtiE, userMBTIView.mbtiI, userMBTIView.mbtiN, userMBTIView.mbtiS, userMBTIView.mbtiT, userMBTIView.mbtiF, userMBTIView.mbtiP, userMBTIView.mbtiJ,]
        for button in buttons {
            button.addTarget(self, action: #selector(mbtiTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc
    private func mbtiTapped(_ sender: MBTIButton) {
        sender.checked()
        switch sender.mbti! {
        case .i:
            userMBTIView.mbtiE.notChecked()
        case .e:
            userMBTIView.mbtiI.notChecked()
        case .n:
            userMBTIView.mbtiS.notChecked()
        case .s:
            userMBTIView.mbtiN.notChecked()
        case .f:
            userMBTIView.mbtiT.notChecked()
        case .t:
            userMBTIView.mbtiF.notChecked()
        case .p:
            userMBTIView.mbtiJ.notChecked()
        case .j:
            userMBTIView.mbtiP.notChecked()
        }
        isNextButtonAvailable()
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let buttons: [MBTIButton] = [userMBTIView.mbtiE, userMBTIView.mbtiI, userMBTIView.mbtiN, userMBTIView.mbtiS, userMBTIView.mbtiT, userMBTIView.mbtiF, userMBTIView.mbtiP, userMBTIView.mbtiJ,]
        var mbtiString = ""
        for button in buttons {
            if button.isMarked() {
                mbtiString += button.mbti!.getValue()
            }
        }
        UserInfoSingletone.typeMBTI(mbtiString)
        let nextVC = UserMajorViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        let buttons: [MBTIButton] = [userMBTIView.mbtiE, userMBTIView.mbtiI, userMBTIView.mbtiN, userMBTIView.mbtiS, userMBTIView.mbtiT, userMBTIView.mbtiF, userMBTIView.mbtiP, userMBTIView.mbtiJ,]
        var count = 0
        for button in buttons {
            if button.isMarked() {
                count += 1
            }
        }
        if count == 4 {
            userMBTIView.nextButton.available()
        }
    }
    
}


import SwiftUI
#Preview {
    UserMBTIViewController()
}
