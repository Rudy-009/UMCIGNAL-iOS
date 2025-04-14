//
//  UserAlcoholView.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class AlcoholView: UIView {
    
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
    
    public lazy var aGlassButton = AlcoholCapabilityButton()
    public lazy var aBottleButton = AlcoholCapabilityButton()
    public lazy var bottlesButton = AlcoholCapabilityButton()
    
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
        self.addSubview(aGlassButton)
        self.addSubview(aBottleButton)
        self.addSubview(bottlesButton)
        
        let width = UIScreen.main.bounds.width - 28
        let height = width * 2.0 / 7.0
        
        aGlassButton.configure(.glass)
        aBottleButton.configure(.aBottle)
        bottlesButton.configure(.bottles)
        
        aGlassButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        aBottleButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(aGlassButton.snp.bottom).offset(8)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        bottlesButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(aBottleButton.snp.bottom).offset(8)
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

