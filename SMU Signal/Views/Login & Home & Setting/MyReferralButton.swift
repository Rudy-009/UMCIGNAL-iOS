//
//  MyRecommandationCodeButton.swift
//  SMU Signal
//
//  Created by 이승준 on 4/20/25.
//

import UIKit

class MyReferralButton: UIButton {
    
    private lazy var myCodeTitleLabel = UILabel().then {
        $0.text = "내 추천인 코드"
        $0.font = Fonts.B3
        $0.textColor = .white
        $0.isUserInteractionEnabled = false
    }
    
    private lazy var codeValueLabel = UILabel().then {
        $0.text = "" // 기본값, 실제로는 API에서 가져온 값으로 설정
        $0.font = Fonts.H1
        $0.textColor = .white
        $0.isUserInteractionEnabled = false
    }
    
    private lazy var documentImageView = UIImageView().then {
        $0.image = .document
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 32
        self.backgroundColor = .P
        self.snp.makeConstraints { make in
            make.height.equalTo(72)
        }
        setConstraints()
    }
    
    private func setConstraints() {
        self.addSubview(documentImageView)
        self.addSubview(myCodeTitleLabel)
        self.addSubview(codeValueLabel)
        
        documentImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(24)
            make.width.height.equalTo(36)
        }
        
        myCodeTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-12)
            make.leading.equalToSuperview().offset(24)
        }
        
        codeValueLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(12)
            make.leading.equalToSuperview().offset(24)
        }
    }
    
    public func setCode(_ code: String) {
        codeValueLabel.text = code
    }
    
    public func getCode() -> String {
        return codeValueLabel.text ?? ""
    }
    
    public func unavailable() {
        self.isEnabled = false
        self.backgroundColor = .P_2
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
