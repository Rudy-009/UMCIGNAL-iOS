//
//  IdealOnBoardingView.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit
import Lottie

class IdealOnBoardingView: UIView {
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "여러분의 데이터를 저장했고\n이제는 이상형 데이터가 필요해요"
        $0.font = UIFont(name: "Pretendard-Bold", size: 24)
        $0.numberOfLines = 2
    }
    
    public lazy var animationView: LottieAnimationView = .init(name: "idealOnboarding")
    
    public lazy var explanationFrame = UIView()
    private lazy var ex1 = UserOnBoardingCell()
    private lazy var ex2 = UserOnBoardingCell()
    
    public lazy var checkButton = ConfirmButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        animationView.play()
    }
    
    func setConstraints() {
        self.addSubview(titleLabel)
        self.addSubview(animationView)
        self.addSubview(explanationFrame)
        explanationFrame.addSubview(ex1)
        explanationFrame.addSubview(ex2)
        self.addSubview(checkButton)
        
        var howFarFromImage: CGFloat = 60
        
        if UIScreen.main.bounds.width <= 375 {
            howFarFromImage = 10
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(30)
            make.bottom.equalTo(animationView.snp.top).offset(-howFarFromImage)
        }
        
        animationView.snp.makeConstraints { make in
            make.height.width.equalTo(300)
            make.bottom.equalTo(explanationFrame.snp.top).offset(-10)
            make.centerX.equalToSuperview()
        }
        
        explanationFrame.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(checkButton.snp.top).offset(-40)
        }
        
        ex1.configure("이상형 데이터로 추천해드려요")
        ex1.snp.makeConstraints { make in
            make.leading.top.trailing.equalToSuperview()
        }
        
        ex2.configure("자체 알고리즘으로 궁합도를 계산해요")
        ex2.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(ex1.snp.bottom)
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

#Preview {
    IdealOnBoardingViewController()
}
