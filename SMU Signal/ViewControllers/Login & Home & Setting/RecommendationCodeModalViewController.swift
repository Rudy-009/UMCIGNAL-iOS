//
//  RecommendationCodeModalView.swift
//  SMU Signal
//
//  Created by 이승준 on 4/21/25.
//

import UIKit

protocol RecommendationCodeModalViewDelegate: AnyObject {
    func didTapConfirmButton(code: String)
}

class RecommendationCodeModalViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: RecommendationCodeModalViewDelegate?
    
    let recView = RecommendationCodeModalView()
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = recView
        hideKeyboardWhenTappedAround()
        setupActions()
        setupKeyboardNotifications()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // 추천인 코드 반영
        recView.myCodeButton.setCode(Singletone.getReferral())
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
    private func setupActions() {
        // 내 추천인 코드 버튼에 탭 액션 추가
        recView.myCodeButton.addTarget(self, action: #selector(copyCodeToClipboard), for: .touchUpInside)
        recView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
    }
    
    private func setupKeyboardNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // MARK: - Actions
    @objc private func copyCodeToClipboard() {
        UIPasteboard.general.string = recView.myCodeButton.getCode()
        recView.codeCoppiedMode()
    }
    
    @objc private func confirmButtonTapped() {
        guard let code = recView.codeTextField.text, !code.isEmpty else {
            return
        }
        delegate?.didTapConfirmButton(code: code)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        // 키보드가 표시될 때 필요한 추가 처리
    }
    
    @objc private func keyboardWillHide(notification: NSNotification) {
        // 키보드가 사라질 때 필요한 추가 처리
    }
    
    // MARK: - Helper Methods
    public func setMyRecommendationCode(_ code: String) {
        recView.myCodeButton.setCode(code)
    }
    
}

extension RecommendationCodeModalViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

