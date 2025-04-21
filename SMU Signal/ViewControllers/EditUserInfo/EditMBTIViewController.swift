//
//  EditMBTIViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/21/25.
//

import UIKit

class EditMBTIViewController: UIViewController {
    private let editMBTIView = MBTIView()
    let nextVC = EditInstagramViewController()
    
    override func viewDidLoad() {
        self.view = editMBTIView
        self.setButtonActions()
        editMBTIView.configure(mainText: "현재 MBTI를 알려주세요.", subText: "", progress: 0.75)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editMBTIView.setButtonConstraints()
    }
    
    private func setButtonActions() {
        editMBTIView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        editMBTIView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
        let buttons: [MBTIButton] = [editMBTIView.mbtiE, editMBTIView.mbtiI, editMBTIView.mbtiN, editMBTIView.mbtiS, editMBTIView.mbtiT, editMBTIView.mbtiF, editMBTIView.mbtiP, editMBTIView.mbtiJ,]
        for button in buttons {
            button.addTarget(self, action: #selector(mbtiTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc
    private func mbtiTapped(_ sender: MBTIButton) {
        sender.checked()
        switch sender.mbti! {
        case .i:
            editMBTIView.mbtiE.notChecked()
        case .e:
            editMBTIView.mbtiI.notChecked()
        case .n:
            editMBTIView.mbtiS.notChecked()
        case .s:
            editMBTIView.mbtiN.notChecked()
        case .f:
            editMBTIView.mbtiT.notChecked()
        case .t:
            editMBTIView.mbtiF.notChecked()
        case .p:
            editMBTIView.mbtiJ.notChecked()
        case .j:
            editMBTIView.mbtiP.notChecked()
        }
        isNextButtonAvailable()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        let buttons: [MBTIButton] = [editMBTIView.mbtiE, editMBTIView.mbtiI, editMBTIView.mbtiN, editMBTIView.mbtiS, editMBTIView.mbtiT, editMBTIView.mbtiF, editMBTIView.mbtiP, editMBTIView.mbtiJ,]
        var mbtiString = ""
        for button in buttons {
            if button.isMarked() {
                mbtiString += button.mbti!.getValue()
            }
        }
        Singletone.editUserMBTI(mbtiString)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func isNextButtonAvailable() {
        let buttons: [MBTIButton] = [editMBTIView.mbtiE, editMBTIView.mbtiI, editMBTIView.mbtiN, editMBTIView.mbtiS, editMBTIView.mbtiT, editMBTIView.mbtiF, editMBTIView.mbtiP, editMBTIView.mbtiJ,]
        var count = 0
        for button in buttons {
            if button.isMarked() {
                count += 1
            }
        }
        if count == 4 {
            editMBTIView.nextButton.available()
        }
    }
}
