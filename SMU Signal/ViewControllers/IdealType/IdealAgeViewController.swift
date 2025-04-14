//
//  IdealAgeViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class IdealAgeViewController: UIViewController {
    
    let idealAgeView = IdealAgeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = idealAgeView
        idealAgeView.configure(mainText: "상대방의 나이를 골라주세요.", subText: " ", progress: 1.0/5.0)
    }
    
    private func setButtonActions() {
        idealAgeView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        idealAgeView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let nextVC = TemplateViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
    private func isNextButtonAvailable() {
        idealAgeView.nextButton.available()
    }
    
}

#Preview {
    IdealAgeViewController()
}
