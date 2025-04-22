//
//  EditAlcoholViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/21/25.
//

import UIKit

class EditAlcoholViewController: UIViewController {
    
    private let editAlcoholView = AlcoholView()
    let nextVC = EditMBTIViewController()
    
    override func viewDidLoad() {
        self.view = editAlcoholView
        self.setButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        editAlcoholView.setButtonConstraints()
        editAlcoholView.configure(mainText: "술 좋아하시나요?", subText: "궁합에서 음주량도 엄청 중요해요.\n여러분의 주량에 대해 알려주세요.", progress: 0.5)
        guard let alcoholCapability = Singletone.editUserInfo.is_drinking else { return }
        switch alcoholCapability {
        case 1:
            editAlcoholView.aGlassButton.checked()
        case 2:
            editAlcoholView.aBottleButton.checked()
        case 3:
            editAlcoholView.bottlesButton.checked()
        default:
            break
        }
    }
    
    private func setButtonActions() {
        editAlcoholView.aGlassButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        editAlcoholView.aBottleButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        editAlcoholView.bottlesButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        editAlcoholView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        editAlcoholView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
    }
    
    @objc
    private func selectAlcohol(_ sender: AlcoholCapabilityButton) {
        let buttons = [editAlcoholView.aGlassButton, editAlcoholView.aBottleButton, editAlcoholView.bottlesButton]
        
        for button in buttons {
            if sender == button {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        editAlcoholView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        let buttons = [editAlcoholView.aGlassButton, editAlcoholView.aBottleButton, editAlcoholView.bottlesButton]
        for button in buttons {
            if button.isChecked {
                Singletone.editDrinking(button.alcohol!.toResponse())
            }
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }

}
