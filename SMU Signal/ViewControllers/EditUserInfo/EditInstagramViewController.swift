//
//  EditInstagramViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/21/25.
//

import UIKit

class EditInstagramViewController: UIViewController, UITextFieldDelegate {
    private let editInstagramIDView = InstagramIDView()
    
    override func viewDidLoad() {
        self.view = editInstagramIDView
        self.setButtonActions()
        self.hideKeyboardWhenTappedAround()
        self.editInstagramIDView.idTextField.delegate = self
        self.editInstagramIDView.idTextField.becomeFirstResponder()
        editInstagramIDView.configure(mainText: "인스타그램 아이디를 입력해주세요.", subText: "개인정보 노출을 최소화하기 위해 UMCignal은 여러분의 인스타그램 아이디 하나만 받고 있어요.", progress: 1.0)
    }
    
    private func setButtonActions() {
        editInstagramIDView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        editInstagramIDView.nextButton.addTarget(self, action: #selector(nextVC), for: .touchUpInside)
        editInstagramIDView.idTextField.addTarget(self, action: #selector(textFieldDidChanged), for: .editingChanged)
    }
    
    @objc
    private func textFieldDidChanged() {
        if editInstagramIDView.idTextField.text! != "" {
            editInstagramIDView.availableMode()
        } else {
            editInstagramIDView.defaultMode()
        }
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func nextVC() {
        postUserInfo()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        postUserInfo()
        return true
    }
    
    private func postUserInfo() {
        Singletone.editInstagram(editInstagramIDView.idTextField.text!)
        // Singletone.saveUserInfoToLocalStorage()
        // API 연동
    }

}
