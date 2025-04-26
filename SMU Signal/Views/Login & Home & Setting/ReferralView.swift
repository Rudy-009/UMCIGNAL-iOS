//
//  RecommendationCodeModalView.swift
//  SMU Signal
//
//  Created by 이승준 on 4/20/25.
//

import UIKit

class ReferralView: UIView {
    
    // 내 추천인 코드 버튼
    public lazy var myCodeButton = MyReferralButton()
    
    // 코드가 복사되었습니다
    public lazy var coppiedLabel = UILabel().then {
        $0.text = "코드가 복사되었습니다."
        $0.font = Fonts.B3
        $0.textColor = .P
        $0.isHidden = true
    }
    
    private lazy var codeFrame = UIView().then {
        $0.layer.cornerRadius = 32
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray100.cgColor
    }
    
    // 추천인 코드 입력 필드
    public lazy var codeTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 33))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        
        $0.placeholder = "추천인 코드 입력"
        $0.font = Fonts.T1
        $0.autocapitalizationType = .none
        $0.autocorrectionType = .no
    }
    
    // 확인 버튼
    public lazy var confirmButton = UIButton().then {
        $0.setTitle("확인", for: .normal)
        $0.setTitleColor(.white, for: .normal)
        $0.titleLabel?.font = Fonts.T2
        $0.backgroundColor = .P
        $0.layer.cornerRadius = 16
    }
    
    // 상태 메시지 라벨
    public lazy var statusLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.B3
        label.textColor = .P
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
        confirmButtonDisableMode()
    }
    
    // MARK: - Setup
    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(myCodeButton)
        self.addSubview(coppiedLabel)
        self.addSubview(codeFrame)
        codeFrame.addSubview(codeTextField)
        codeFrame.addSubview(confirmButton)
        self.addSubview(statusLabel)
    }
    
    private func setupConstraints() {
        // 내 추천인 코드 버튼
        myCodeButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // 코드가 복사되었습니다. 메시지
        coppiedLabel.snp.makeConstraints { make in
            make.top.equalTo(myCodeButton.snp.bottom).offset(10)
            make.left.equalTo(myCodeButton.snp.left).offset(24)
        }
        
        codeFrame.snp.makeConstraints { make in
            make.top.equalTo(myCodeButton.snp.bottom).offset(30)
            make.right.equalToSuperview().inset(20)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(72)
        }
                
        // 확인 버튼
        confirmButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(79)
            make.height.equalTo(32)
        }
        
        // 추천인 코드 입력 필드
        codeTextField.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.equalTo(50)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalTo(confirmButton.snp.leading)
        }
        
        // 상태 메시지 라벨
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(codeFrame.snp.bottom).offset(10)
            make.left.equalTo(codeFrame.snp.left).offset(24)
        }
    }
    
    func codeDefaultMode() {
        codeFrame.layer.borderColor = UIColor.gray100.cgColor
        statusLabel.isHidden = true
    }
    
    func codeCoppiedMode() {
        coppiedLabel.isHidden = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.coppiedLabel.isHidden = true
        }
    }
    
//    enum ReferralCode: Int {
//        case success = 200 //..<300 V
//        case notLogined = 401 // 로그인 되어 있지 않을 때 (401): '로그인 되어있지 않습니다.'
//        case expired = 403
//        case notFound = 404 // 토큰이 없을 때 (404): '토큰이 없습니다.', 추천 코드가 없을 때 (404): '추천 코드가 없습니다.'
//        case alreadyUsed = 409 //
//        case error   = 500 // 서버 에러 (500): '서버 에러입니다.'
//    }
//
//    enum SericalCode: Int {
//        case success = 200 //..<300 V
//        case alreadyUsed = 400 // 이미 사용된 코드일 때 (400): '이미 사용된 코드입니다.'
//        case exporedToken = 401  // 토큰이 유효하지 않을 때 (401): '토큰이 유효하지 않습니다.', // 로그인 되어 있지 않을 때 (401): '로그인 되어있지 않습니다.'
//        case expired = 403
//        case notFound = 404 // 코드가 없을 때 (404): '코드를 입력해주세요.', 존재하지 않는 코드일 때 (404): '존재하지 않는 코드입니다.'
//        case error = 500 // 서버 에러 (500): '서버 에러입니다.' - 없는 serical Code일 때
//    }
    
    func successedMode() {
        codeDefaultMode()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.codeFrame.layer.borderColor = UIColor.P.cgColor
            
            self.statusLabel.text = "코드가 적용되었습니다."
            self.statusLabel.textColor = .P
            self.statusLabel.isHidden = false
        }
    }
    
    func codeNotLoginedMode() {
        somethingWentWrongMode("로그인 되어있지 않습니다.")
    }
    
    func notFoundCodeMode() {
        somethingWentWrongMode("존재하지 않는 코드입니다.")
    }
    
    func alreadyUsedCodeMode() {
        somethingWentWrongMode("이미 사용된 코드입니다.")
    }
    
    func expiredTokenMode() {
        somethingWentWrongMode("만료된 토큰입니다.")
    }
    
    func serialCodeErrorMode() {
        somethingWentWrongMode("존재하지 않는 코드입니다.")
    }
    
    func referralErrorMode() {
        somethingWentWrongMode("존재하지 않는 코드입니다.")
    }
    
    func somethingWentWrongMode(_ message: String) {
        codeDefaultMode()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.codeFrame.layer.borderColor = UIColor.red400.cgColor
            
            self.statusLabel.text = message
            self.statusLabel.textColor = .red400
            self.statusLabel.isHidden = false
        }
    }
    
    func confirmButtonEnableMode() {
        confirmButton.backgroundColor = .P
        confirmButton.isEnabled = true
    }
    
    func confirmButtonDisableMode() {
        confirmButton.backgroundColor = .gray100
        confirmButton.isEnabled = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
