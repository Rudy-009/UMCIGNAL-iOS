//
//  SmokeSelectionView.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class SmokeView: UIView {
    
    private var screenMargin: CGFloat = 14
    private let buttonSpacing: CGFloat = 15
    
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
    
    public lazy var nonSmokerButton = SmokeButton()
    public lazy var smokerButton = SmokeButton()
    
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
        
        nextButton.configure(labelText: "다음")
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
    }
    
    public func setButtonConstraints() {
        nonSmokerButton.configure(.none)
        smokerButton.configure(.smoker)
        
        self.addSubview(smokerButton)
        self.addSubview(nonSmokerButton)
        
        let screenWidth = UIScreen.main.bounds.width
        var buttonWidth = (screenWidth - (screenMargin * 2 + buttonSpacing)) / 2
        
        if screenWidth <= 375 {
            screenMargin = 28
            buttonWidth = (screenWidth - (screenMargin * 2 + buttonSpacing)) / 2
        }
        
        smokerButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonWidth)
            make.leading.equalToSuperview().offset(screenMargin)
            make.centerY.equalToSuperview().offset(30)
        }
        
        nonSmokerButton.snp.makeConstraints { make in
            make.width.height.equalTo(buttonWidth)
            make.trailing.equalToSuperview().inset(screenMargin)
            make.centerY.equalTo(smokerButton)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
