//
//  UserInstagramIDView.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class InstagramIDView: UIView {
    
    public lazy var navigationBar = NavigationBarView()
    public lazy var progressBar = ProgressBar()
    private lazy var mainTitle = UILabel().then {
        $0.font = Fonts.H1
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private lazy var subTitle = UILabel().then {
        $0.font = Fonts.B1
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 4
    }
    
    public lazy var idTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 33))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        
        $0.font = Fonts.B2
        $0.textColor = .black
        $0.tintColor = .TB
        
        $0.layer.borderColor = UIColor.gray100.cgColor
        $0.layer.borderWidth = 1
        $0.layer.cornerRadius = 8
        $0.clipsToBounds = true
        
        $0.enablesReturnKeyAutomatically = false
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
        $0.spellCheckingType = .no
    }
    
    public lazy var nextButton = ConfirmButton()
    
    public lazy var privacyPolicyButton = UIButton().then {
        $0.setImage(.leftButton, for: .normal)
    }
    public lazy var checkbox = CheckBoxButton()
    public lazy var agreeLabel = UILabel().then {
        $0.text = "개인정보처리방침 동의"
    }
    private lazy var requiredLabel = UILabel().then {
        $0.text = "필수"
        $0.textColor = .white
        $0.font = Fonts.B1
        $0.backgroundColor = .TB
        $0.textAlignment = .center
        
        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setBasicConstraints()
    }
    
    public func signUpMode() {
        self.addSubview(privacyPolicyButton)
        self.addSubview(checkbox)
        self.addSubview(agreeLabel)
        self.addSubview(requiredLabel)
        
        checkbox.configure(false)
        checkbox.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(25)
            make.height.width.equalTo(44)
            make.top.equalTo(idTextField.snp.bottom).offset(20)
        }
        
        agreeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkbox)
            make.leading.equalTo(checkbox.snp.trailing)
        }
        
        requiredLabel.snp.makeConstraints { make in
            make.centerY.equalTo(agreeLabel)
            make.leading.equalTo(agreeLabel.snp.trailing).offset(10)
            make.height.equalTo(25)
            make.width.equalTo(40)
        }
        
        privacyPolicyButton.snp.makeConstraints { make in
            make.centerY.equalTo(agreeLabel)
            make.leading.equalTo(requiredLabel.snp.trailing).offset(-10)
            make.width.height.equalTo(50)
        }
    }
    
    public func configure(mainText: String, subText: String, progress: Float) {
        mainTitle.text = mainText
        subTitle.text = subText
        progressBar.progress = progress
    }
    
    public func defaultMode() {
        self.idTextField.layer.borderWidth = 2
        self.idTextField.layer.borderColor = UIColor.gray100.cgColor
        self.nextButton.unavailable()
    }
    
    public func availableMode() {
        self.idTextField.layer.borderWidth = 2
        self.idTextField.layer.borderColor = UIColor.TB.cgColor
        self.nextButton.available()
    }
    
    private func setBasicConstraints() {
        self.addSubview(navigationBar)
        self.addSubview(progressBar)
        self.addSubview(mainTitle)
        self.addSubview(subTitle)
        self.addSubview(idTextField)
        self.addSubview(nextButton)
        
        navigationBar.hideRightButton()
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        idTextField.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.top.equalTo(subTitle.snp.bottom).offset(24)
            make.height.equalTo(46)
        }
        
        nextButton.configure(labelText: "다음")
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview {
    UserInstagramIDViewController()
}
