//
//  SexSelectionView.swift
//  UMCignal
//
//  Created by 이승준 on 4/7/25.
//

import UIKit

class GenderView: UIView {
    
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
        $0.numberOfLines = 2
    }
    
    public lazy var nextButton = ConfirmButton()
    
    private lazy var buttonFrame = UIView()
    public lazy var maleButton = GenderButton()
    public lazy var femaleButton = GenderButton()
    public lazy var otherButton = GenderButton()
    
    public lazy var extraLabel = UILabel().then {
        $0.text = "그 외 성별은 그 외 성별분들끼리만 매칭돼요."
        $0.font = Fonts.Detail
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setBasicConstraints()
    }
    
    public func configure(mainText: String, subText: String, progress: Float) {
        mainTitle.text = mainText
        subTitle.text = subText
        progressBar.progress = progress
    }
    
    private func setBasicConstraints() {
        self.addSubview(navigationBar)
        self.addSubview(progressBar)
        self.addSubview(mainTitle)
        self.addSubview(subTitle)
        self.addSubview(extraLabel)
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
        
        extraLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        nextButton.configure(labelText: "다음")
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
    }
    
    public func setButtonConstraints() {
        self.addSubview(buttonFrame)
        
        let screenWidth = UIScreen.main.bounds.width
        var frameSize: CGFloat = screenWidth - 28
        if screenWidth <= 375 {
            frameSize = screenWidth * 0.7
        }

        let buttonSize = (frameSize - 16) / 2
        
        buttonFrame.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.width.equalTo(frameSize)
            make.bottom.equalTo(nextButton.snp.top).offset(-20)
        }
        
        maleButton.configure(.male)
        femaleButton.configure(.female)
        otherButton.configure(.other)
        buttonFrame.addSubview(maleButton)
        buttonFrame.addSubview(femaleButton)
        buttonFrame.addSubview(otherButton)
                
        maleButton.snp.makeConstraints { make in
            make.height.width.equalTo(buttonSize)
            make.leading.top.equalToSuperview()
        }
        
        femaleButton.snp.makeConstraints { make in
            make.height.width.equalTo(buttonSize)
            make.trailing.top.equalToSuperview()
        }
        
        otherButton.snp.makeConstraints { make in
            make.height.width.equalTo(buttonSize)
            make.centerX.equalToSuperview()
            if screenWidth <= 375 {
                make.bottom.equalToSuperview()
            } else {
                make.bottom.equalToSuperview().offset(-6)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview {
    UserGenderViewController()
}
