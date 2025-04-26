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

class ReferralViewController: UIViewController {
    
    // MARK: - Properties
    weak var delegate: RecommendationCodeModalViewDelegate?
    
    let recView = ReferralView()
    
    // MARK: - Initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view = recView
        hideKeyboardWhenTappedAround()
        setupActions()
        recView.codeTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        recView.myCodeButton.setCode(Singletone.getReferral())
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
        
    private func setupActions() {
        // 내 추천인 코드 버튼에 탭 액션 추가
        recView.myCodeButton.addTarget(self, action: #selector(copyCodeToClipboard), for: .touchUpInside)
        recView.confirmButton.addTarget(self, action: #selector(confirmButtonTapped), for: .touchUpInside)
        recView.codeTextField.addTarget(self, action: #selector(codeTextFieldDidChange), for: .editingChanged)
    }
    
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
    
    // MARK: - Helper Methods
    public func setMyRecommendationCode(_ code: String) {
        recView.myCodeButton.setCode(code)
    }
    
    // 코드 유효성 검사 6 or 8 이면 버튼 활성화
    @objc
    private func codeTextFieldDidChange(_ sender: UITextField) {
        let text = recView.codeTextField.text ?? ""
        if text.count == 6 || text.count == 8 {
            recView.confirmButtonEnableMode()
        } else {
            recView.confirmButtonDisableMode()
        }
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let maxLength = 8
        let currentString: NSString = (textField.text ?? "") as NSString
        let newString: NSString = currentString.replacingCharacters(in: range, with: string) as NSString
        return newString.length <= maxLength
    }
    
}

extension ReferralViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        guard let code = recView.codeTextField.text, !code.isEmpty else {
            return false
        }
        delegate?.didTapConfirmButton(code: code)
        return true
    }
}

