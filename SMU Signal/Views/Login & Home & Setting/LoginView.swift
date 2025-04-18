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
    
    var topPadding: CGFloat = 100
    
    private lazy var mainTitle = UILabel().then {
        $0.text = "로그인"
        $0.font = Fonts.H1
    }
    
    private lazy var subTitle = UILabel().then {
        $0.text = "학번만 기재할 경우\n메일주소가 자동으로 반영되어서 전송됩니다."
        $0.numberOfLines = 2
        $0.font = Fonts.B1R
    }
    
    public lazy var emailTextField = textField("202500000")
    public lazy var emailSubLabel = UILabel().then {
        $0.textColor = .TB
        $0.font = Fonts.B3
        $0.numberOfLines = 2
    }
    public lazy var sendVerifyCodeButton = ConfirmButton()
    
    public lazy var codeTextField = textField("6자리코드")
    public lazy var codeSubLabel = UILabel().then {
        $0.text = "인증코드는 6자리입니다."
        $0.textColor = .red400
        $0.font = Fonts.B3
    }
    
    public lazy var loginButton = ConfirmButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
        self.backgroundColor = . white
        defaultMode()
    }
    
    public func defaultMode() {
        emailSubLabel.isHidden = true
        codeSubLabel.isHidden = true
    }
    
    public func codeSentMode() {
        let text = emailTextField.text! + "@sangmyung.kr로 인증코드를 보냈습니다\n스펨메일함도 확인해주세요."
        emailSubLabel.text = text
        emailSubLabel.isHidden = false
    }
    
    public func codeLengthWarning() {
        codeSubLabel.text = "인증코드는 6자리입니다."
        codeSubLabel.isHidden = false
    }
    
    public func codeIsNotValidMode() {
        codeSubLabel.text = "유효하지 않은 코드입니다."
        codeSubLabel.isHidden = false
    }
    
    // 키보드가 올라올 때 호출
    public func keyBoardWillAppear(keyboardHeight: CGFloat) {
        // topPadding 변경
        self.topPadding = 20
        // mainTitle의 top 제약 업데이트
        mainTitle.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(topPadding)
        }
        // loginButton을 키보드 위로 올림
        loginButton.snp.updateConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(keyboardHeight + 8)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    // 키보드가 내려갈 때 호출
    public func keyBoardWillDisappear() {
        // topPadding 원복
        self.topPadding = 100
        mainTitle.snp.updateConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(topPadding)
        }
        // loginButton 원래 위치로
        loginButton.snp.updateConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func setupConstraints() {
        self.addSubview(mainTitle)
        self.addSubview(subTitle)
        self.addSubview(emailTextField)
        self.addSubview(sendVerifyCodeButton)
        self.addSubview(emailSubLabel)
        self.addSubview(codeTextField)
        self.addSubview(codeSubLabel)
        self.addSubview(loginButton)
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(topPadding)
            make.leading.equalToSuperview().offset(14)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(14)
        }
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(24)
            make.width.equalTo(327)
            make.height.equalTo(72)
            make.centerX.equalToSuperview()
        }
        emailSubLabel.snp.makeConstraints { make in
            make.leading.equalTo(emailTextField.snp.leading).offset(24)
            make.top.equalTo(emailTextField.snp.bottom).offset(8)
        }
        
        sendVerifyCodeButton.configure(labelText: "인증코드 전송")
        sendVerifyCodeButton.snp.makeConstraints { make in
            make.centerY.equalTo(emailTextField)
            make.trailing.equalTo(emailTextField).inset(24)
            make.width.equalTo(136)
        }
        sendVerifyCodeButton.snp.updateConstraints { make in
            make.height.equalTo(36)
        }
        
        codeTextField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalTo(327)
            make.height.equalTo(72)
            make.top.equalTo(emailTextField.snp.bottom).offset(48)
        }
        codeSubLabel.snp.makeConstraints { make in
            make.leading.equalTo(codeTextField.snp.leading).offset(24)
            make.top.equalTo(codeTextField.snp.bottom).offset(8)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
    }
    
    private func textField(_ placeHolder: String) -> UITextField {
        return UITextField().then {
            $0.font = Fonts.T1
            $0.layer.borderWidth = 1
            $0.layer.borderColor = UIColor.gray100.cgColor
            $0.layer.cornerRadius = 8
            $0.clipsToBounds = true
            $0.textColor = .black
            $0.tintColor = .black
            $0.setPlaceholder(text: placeHolder, color: .gray)
            $0.snp.makeConstraints { make in
                make.width.equalTo(327)
                make.height.equalTo(72)
            }
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 33))
            $0.leftView = paddingView
            $0.leftViewMode = .always
            $0.keyboardType = .decimalPad
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
