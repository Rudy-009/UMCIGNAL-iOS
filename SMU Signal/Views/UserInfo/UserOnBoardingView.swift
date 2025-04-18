//
//  UserInfoOnBoardingView.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class UserOnBoardingView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "스뮤시그널 사용 전에\n몇 가지를 알려주세요"
        $0.font = UIFont(name: "Pretendard-Bold", size: 24)
        $0.numberOfLines = 2
    }
    
    public lazy var mainGiftImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.backgroundColor = .P_2
    }
    
    public lazy var explanationFrame = UIView()
    private lazy var ex1 = UserOnBoardingCell()
    private lazy var ex2 = UserOnBoardingCell()
    private lazy var ex3 = UserOnBoardingCell()
    
    public lazy var checkButton = ConfirmButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
    }
    
    func setConstraints() {
        self.addSubview(titleLabel)
        self.addSubview(mainGiftImageView)
        self.addSubview(explanationFrame)
        explanationFrame.addSubview(ex1)
        explanationFrame.addSubview(ex2)
        explanationFrame.addSubview(ex3)
        self.addSubview(checkButton)
        
        var howFarFromImage: CGFloat = 60
        
        if UIScreen.main.bounds.width <= 375 {
            howFarFromImage = 10
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.bottom.equalTo(mainGiftImageView.snp.top).offset(-howFarFromImage)
        }
        
        mainGiftImageView.snp.makeConstraints { make in
            make.height.width.equalTo(300)
            make.bottom.equalTo(explanationFrame.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        explanationFrame.snp.makeConstraints { make in
            make.height.equalTo(150)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(checkButton.snp.top).offset(-10)
        }
        
        ex1.configure("성별, 나이, 흡연, 음주 데이터를 받아요")
        ex1.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        ex2.configure("MBTI로 최적의 상대를 추천해드려요")
        ex2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(ex1.snp.bottom)
        }
        
        ex3.configure("프로필 없이 인스타그램으로 소통해요")
        ex3.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(ex2.snp.bottom)
        }
        
        checkButton.available()
        checkButton.configure(labelText: "확인")
        checkButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

class UserOnBoardingCell: UIView {
    private lazy var checkImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .check3D
    }
    
    private lazy var titleLabel = UILabel().then {
        $0.font = Fonts.B1B
    }
    
    func configure(_ text: String) {
        titleLabel.text = text
    }
    
    private func setConstraints() {
        self.addSubview(checkImage)
        self.addSubview(titleLabel)
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(checkImage)
            make.leading.equalTo(checkImage.snp.trailing)
        }
        
        checkImage.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.leading.top.bottom.equalToSuperview()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    UserOnBoardingViewController()
}
