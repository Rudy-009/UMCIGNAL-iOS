//
//  IdealMBTIViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class IdealMBTIViewController: UIViewController {
    
    private let IdealMBTIView = MBTIView()
    let nextVC = IdealMajorViewController()
    
    override func viewDidLoad() {
        self.view = IdealMBTIView
        self.setButtonActions()
        IdealMBTIView.configure(mainText: "선호하는 MBTI를 알려주세요.", subText: " ", progress: 4.0/5.0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        IdealMBTIView.setButtonConstraints()
    }
    
    private func setButtonActions() {
        IdealMBTIView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        IdealMBTIView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
        let buttons: [MBTIButton] = [IdealMBTIView.mbtiE, IdealMBTIView.mbtiI, IdealMBTIView.mbtiN, IdealMBTIView.mbtiS, IdealMBTIView.mbtiT, IdealMBTIView.mbtiF, IdealMBTIView.mbtiP, IdealMBTIView.mbtiJ,]
        for button in buttons {
            button.addTarget(self, action: #selector(mbtiTapped(_:)), for: .touchUpInside)
        }
    }
    
    @objc
    private func mbtiTapped(_ sender: MBTIButton) {
        sender.checked()
        switch sender.mbti! {
        case .i:
            IdealMBTIView.mbtiE.notChecked()
        case .e:
            IdealMBTIView.mbtiI.notChecked()
        case .n:
            IdealMBTIView.mbtiS.notChecked()
        case .s:
            IdealMBTIView.mbtiN.notChecked()
        case .f:
            IdealMBTIView.mbtiT.notChecked()
        case .t:
            IdealMBTIView.mbtiF.notChecked()
        case .p:
            IdealMBTIView.mbtiJ.notChecked()
        case .j:
            IdealMBTIView.mbtiP.notChecked()
        }
        isNextButtonAvailable()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        let buttons: [MBTIButton] = [IdealMBTIView.mbtiE, IdealMBTIView.mbtiI, IdealMBTIView.mbtiN, IdealMBTIView.mbtiS, IdealMBTIView.mbtiT, IdealMBTIView.mbtiF, IdealMBTIView.mbtiP, IdealMBTIView.mbtiJ,]
        var mbtiString = ""
        for button in buttons {
            if button.isMarked() {
                mbtiString += button.mbti!.getValue()
            }
        }
        Singletone.typeIdealMBTI(mbtiString)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func isNextButtonAvailable() {
        let buttons: [MBTIButton] = [IdealMBTIView.mbtiE, IdealMBTIView.mbtiI, IdealMBTIView.mbtiN, IdealMBTIView.mbtiS, IdealMBTIView.mbtiT, IdealMBTIView.mbtiF, IdealMBTIView.mbtiP, IdealMBTIView.mbtiJ,]
        var count = 0
        for button in buttons {
            if button.isMarked() {
                count += 1
            }
        }
        if count == 4 {
            IdealMBTIView.nextButton.available()
        }
    }
    
}
