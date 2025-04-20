//
//  RecommendationCodeModalView.swift
//  SMU Signal
//
//  Created by 이승준 on 4/20/25.
//

import UIKit

class RecommendationCodeModalView: UIView {
    
    // 내 추천인 코드 버튼
    public lazy var myCodeButton = MyRecommandationCodeButton()
    
    // 추천인 코드 입력 필드
    public lazy var codeTextField = UITextField().then {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 20, height: 33))
        $0.leftView = paddingView
        $0.leftViewMode = .always
        
        $0.layer.cornerRadius = 32
        $0.layer.borderWidth = 1
        $0.layer.borderColor = UIColor.gray100.cgColor
        
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
    }
    
    // MARK: - Setup
    private func setupViews() {
        self.backgroundColor = .white
        
        self.addSubview(myCodeButton)
        self.addSubview(codeTextField)
        codeTextField.addSubview(confirmButton)
        self.addSubview(statusLabel)
    }
    
    private func setupConstraints() {
        // 내 추천인 코드 버튼
        myCodeButton.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide.snp.top).offset(20)
            make.left.right.equalToSuperview().inset(20)
        }
        
        // 추천인 코드 입력 필드
        codeTextField.snp.makeConstraints { make in
            make.top.equalTo(myCodeButton.snp.bottom).offset(30)
            make.left.right.equalToSuperview().inset(20)
            make.height.equalTo(72)
        }
        
        // 확인 버튼
        confirmButton.snp.makeConstraints { make in
            make.centerY.equalTo(codeTextField)
            make.right.equalToSuperview().offset(-20)
            make.width.equalTo(79)
            make.height.equalTo(32)
        }
        
        // 상태 메시지 라벨
        statusLabel.snp.makeConstraints { make in
            make.top.equalTo(codeTextField.snp.bottom).offset(10)
            make.centerX.equalToSuperview()
            make.left.equalTo(codeTextField.snp.left).offset(24)
        }
    }
    
    func codeAppliedMode() {
        codeTextField.layer.borderColor = UIColor.P.cgColor
        
        statusLabel.text = "추천인 코드가 적용되었습니다."
        statusLabel.textColor = .P
        statusLabel.isHidden = false
    }
    
    func codeNotFoiundMode() {
        codeTextField.layer.borderColor = UIColor.red400.cgColor
        
        statusLabel.text = "추천 코드가 없습니다."
        statusLabel.textColor = .red400
        statusLabel.isHidden = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
