//
//  BirthdaySelectionViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserBirthdayViewController: UIViewController {
    
    private let userBirthdayView = BirthdayView()
    
    override func viewDidLoad() {
        self.view = userBirthdayView
        self.setButtonActions()
        userBirthdayView.configure(mainText: "생일도 알려주세요.", subText: "여러분의 나이를 확인하기 위함입니다.", progress: 2.0/7.0)
    }
    
    private func setButtonActions() {
        userBirthdayView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userBirthdayView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        userBirthdayView.datePicker.addTarget(self, action: #selector(datePickerValueChanged), for: .valueChanged)
    }
    
    @objc
    private func datePickerValueChanged() {
        userBirthdayView.nextButton.available()
    }
    
    @objc
    private func popVC() {
        dismiss(animated: false)
    }
    
    @objc
    private func nextVC() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let birthday = userBirthdayView.datePicker.date
        let formattedDate = dateFormatter.string(from: birthday)
        UserInfoSingletone.typeAge(formattedDate)
        
        let nextVC = UserSmokeViewController()
        nextVC.modalPresentationStyle = .overFullScreen
        present(nextVC, animated: false)
    }
    
}


import SwiftUI
#Preview {
    UserBirthdayViewController()
}
