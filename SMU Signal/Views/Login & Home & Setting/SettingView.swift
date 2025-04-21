//
//  SettingView.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit

class SettingView: UIView {
    
    public lazy var popButton = UIButton().then {
        $0.setImage(.rightArrow, for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var mainFrame = UIView().then {
        $0.clipsToBounds = true
        $0.layer.borderColor = UIColor.gray200.cgColor
        $0.layer.borderWidth = 2
        $0.layer.cornerRadius = 32
    }
    
    private lazy var termOfUseLabel = label("이용약관")
    public lazy var termOfUseButton = leftArrow()
    private lazy var privacyPolicyLabel = label("개인정보처리방침")
    public lazy var privacyPolicyButton = leftArrow()
    public lazy var logout = textButton("로그아웃")
    public lazy var revoke = textButton("회원탈퇴")
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
        self.backgroundColor = .white
    }
    
    private func setConstraints() {
        self.addSubview(popButton)
        self.addSubview(mainFrame)
        
        popButton.snp.makeConstraints { make in
            make.leading.equalToSuperview()
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.height.equalTo(80)
            make.width.equalTo(120)
        }
        
        popButton.imageView?.snp.makeConstraints { make in
            make.height.equalTo(24)
            make.width.equalTo(12)
            make.centerX.equalToSuperview().offset(-20)
        }
        
        mainFrame.snp.makeConstraints { make in
            make.top.equalTo(popButton.snp.bottom).offset(19)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(220)
        }
        
        mainFrame.addSubview(termOfUseLabel)
        mainFrame.addSubview(termOfUseButton)
        mainFrame.addSubview(privacyPolicyLabel)
        mainFrame.addSubview(privacyPolicyButton)
        mainFrame.addSubview(logout)
        mainFrame.addSubview(revoke)
        
        let leadingPadding: CGFloat = 20
        
        termOfUseLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(27)
            make.leading.equalToSuperview().offset(leadingPadding)
        }
        
        termOfUseButton.snp.makeConstraints { make in
            make.centerY.equalTo(termOfUseLabel)
            make.height.equalTo(44)
            make.width.equalTo(60)
            make.trailing.equalToSuperview()
        }
        
        privacyPolicyLabel.snp.makeConstraints { make in
            make.top.equalTo(termOfUseLabel.snp.bottom).offset(27)
            make.leading.equalToSuperview().offset(leadingPadding)
        }
        
        privacyPolicyButton.snp.makeConstraints { make in
            make.centerY.equalTo(privacyPolicyLabel)
            make.height.equalTo(44)
            make.width.equalTo(60)
            make.trailing.equalToSuperview()
        }
        
        logout.snp.makeConstraints { make in
            make.top.equalTo(privacyPolicyLabel.snp.bottom).offset(15)
            make.leading.equalToSuperview().offset(leadingPadding)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        logout.titleLabel?.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-24)
        }
        
        revoke.snp.makeConstraints { make in
            make.top.equalTo(logout.snp.bottom)
            make.leading.equalToSuperview().offset(leadingPadding)
            make.width.equalTo(100)
            make.height.equalTo(44)
        }
        
        revoke.titleLabel?.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-24)
        }

        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func label(_ text: String) -> UILabel {
        return UILabel().then {
            $0.text = text
            $0.font = Fonts.B1
            $0.textColor = .black
        }
    }
    
    func leftArrow() -> UIButton {
        return UIButton().then {
            $0.setImage(.leftButton , for: .normal)
            $0.contentMode = .scaleAspectFit
        }
    }
    
    func textButton(_ text: String) -> UIButton {
        return UIButton().then {
            $0.setTitle(text, for: .normal)
            $0.titleLabel?.font = Fonts.B1
            $0.setTitleColor(.red400, for: .normal)
        }
    }
    
    
}

#Preview {
    SettingViewController()
}
