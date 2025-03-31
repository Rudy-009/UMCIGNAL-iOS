//
//  LoginView.swift
//  UMCignal
//
//  Created by 이승준 on 3/31/25.
//

import UIKit
import SnapKit
import Then

class LoginView: UIView {
    
    public lazy var emailTextField = textField("학교학번@sangmyung.kr")
    
    public lazy var sendVerifyCodeButton = button(title: "확인 코드 보내기")
    
    public lazy var codeTextField = textField("6자리코드")
    
    public lazy var loginButton = button(title: "로그인")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.backgroundColor = . white
    }
    
    private func setupConstraints() {
        self.addSubview(emailTextField)
        self.addSubview(sendVerifyCodeButton)
        self.addSubview(codeTextField)
        self.addSubview(loginButton)
        
        emailTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
        }
        
        sendVerifyCodeButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(emailTextField.snp.bottom).offset(10)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(sendVerifyCodeButton.snp.bottom).offset(10)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(codeTextField.snp.bottom).offset(10)
        }
    }
    
    private func textField(_ placeHolder: String) -> UITextField {
        return UITextField().then {
            $0.font = .systemFont(ofSize: 25)
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.setPlaceholder(text: placeHolder, color: .gray)
        }
    }
    
    private func button(title: String) -> UIButton {
        return UIButton().then {
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.black.cgColor
            $0.setTitleColor(.black, for: .normal)
            $0.setTitle(title, for: .normal)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import SwiftUI
#Preview {
    LoginViewController()
}
