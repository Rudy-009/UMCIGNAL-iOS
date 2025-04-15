//
//  LoginFailedView.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class LoginFailedView: UIView {
    
    private lazy var logoImageView = UIImageView().then {
        $0.image = .umung
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var securityFrame = UIView()
    private lazy var securityImageView = UIImageView().then {
        $0.image = .shield
        $0.contentMode = .scaleAspectFit
    }
    private lazy var securityLabel = UILabel().then {
        $0.text = "개인정보 보호 모드 작동중"
        $0.textColor = .white
        $0.font = Fonts.T2
    }
    
    public lazy var loginButton = UIButton().then {
        $0.setTitle("로그인", for: .normal)
        $0.titleLabel?.font = Fonts.T2
        $0.setTitleColor(.TB, for: .normal)
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 12
    }
    
    private func setupConstraints() {
        self.addSubview(logoImageView)
        self.addSubview(securityFrame)
        securityFrame.addSubview(securityImageView)
        securityFrame.addSubview(securityLabel)
        self.addSubview(loginButton)
        
        logoImageView.snp.makeConstraints { make in
            make.height.width.equalTo(200)
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-40)
        }
        
        loginButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.height.equalTo(50)
            make.bottom.equalTo(self.safeAreaLayoutGuide.snp.bottom).offset(-40)
        }
        
        securityFrame.snp.makeConstraints { make in
            make.width.equalTo(262)
            make.height.equalTo(60)
            make.centerX.equalToSuperview()
            make.bottom.equalTo(loginButton.snp.top).offset(-24)
        }
        
        securityImageView.snp.makeConstraints { make in
            make.width.height.equalTo(60)
            make.leading.centerY.equalToSuperview()
        }
        
        securityLabel.snp.makeConstraints { make in
            make.leading.equalTo(securityImageView.snp.trailing)
            make.trailing.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .TB
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview {
    LoginFailedViewController()
}
