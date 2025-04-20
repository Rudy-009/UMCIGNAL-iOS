//
//  File.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class IdealAlcoholViewController: UIViewController {
    
    private let idealAlcocholView = AlcoholView()
    let nextVC = IdealMBTIViewController()
    
    override func viewDidLoad() {
        self.view = idealAlcocholView
        self.setButtonActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        idealAlcocholView.setButtonConstraints()
        idealAlcocholView.configure(mainText: "상대방이 음주를 어느 정도\n하면 좋을까요? ", subText: " ", progress: 3.0/5.0)
        guard let alcoholCapability = Singletone.idealType.drinking_idle else { return }
        switch alcoholCapability {
        case 1:
            idealAlcocholView.aGlassButton.checked()
        case 2:
            idealAlcocholView.aBottleButton.checked()
        case 3:
            idealAlcocholView.bottlesButton.checked()
        default:
            break
        }
    }
    
    private func setButtonActions() {
        idealAlcocholView.aGlassButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        idealAlcocholView.aBottleButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        idealAlcocholView.bottlesButton.addTarget(self, action: #selector(selectAlcohol(_:)), for: .touchUpInside)
        idealAlcocholView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        idealAlcocholView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
    }
    
    @objc
    private func selectAlcohol(_ sender: AlcoholCapabilityButton) {
        let buttons = [idealAlcocholView.aGlassButton, idealAlcocholView.aBottleButton, idealAlcocholView.bottlesButton]
        
        for button in buttons {
            if sender == button {
                button.checked()
            } else {
                button.notChecked()
            }
        }
        idealAlcocholView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        let buttons = [idealAlcocholView.aGlassButton, idealAlcocholView.aBottleButton, idealAlcocholView.bottlesButton]
        for button in buttons {
            if button.isChecked {
                Singletone.typeDrinkingIdle(button.alcohol!.toResponse())
            }
        }
        navigationController?.pushViewController(nextVC, animated: true)
    }

    
}
