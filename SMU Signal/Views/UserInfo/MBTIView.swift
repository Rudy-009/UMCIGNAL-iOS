//
//  UserMBTIView.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class MBTIView: UIView {
    
    private let padding: CGFloat = 78
    private let buttonMargin: CGFloat = 11
    
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
    
    public lazy var mbtiE = MBTIButton(); public lazy var mbtiI = MBTIButton()
    public lazy var mbtiN = MBTIButton(); public lazy var mbtiS = MBTIButton()
    public lazy var mbtiF = MBTIButton(); public lazy var mbtiT = MBTIButton()
    public lazy var mbtiP = MBTIButton(); public lazy var mbtiJ = MBTIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setBasicConstraints()
        let buttons: [MBTIButton] = [mbtiE, mbtiI, mbtiS, mbtiN, mbtiF, mbtiT, mbtiJ, mbtiP]
        let mbti: [MBTIEnum] = [.e, .i, .s, .n, .f, .t, .j, .p]
        for (index, button) in buttons.enumerated() {
            button.configure(mbti[index])
        }
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
        let screenWidth = UIScreen.main.bounds.width
        var width = ( screenWidth - ( padding * 2 + buttonMargin )) / 2.0
        var height: CGFloat = width * (96/104)
        var mainTitlePadding: CGFloat = 20
        if screenWidth <= 375 {
            width = ( screenWidth - ( padding * 2 + buttonMargin )) / 2.3
            height = width * (96/104)
            mainTitlePadding = 10
        }
        
        let buttons: [MBTIButton] = [mbtiE, mbtiI, mbtiN, mbtiS, mbtiF, mbtiT, mbtiJ, mbtiP]
        for button in buttons {
            self.addSubview(button)
            button.snp.makeConstraints { make in
                make.width.equalTo(width)
                make.height.equalTo(height)
            }
        }
        
        mbtiE.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(mainTitlePadding)
            make.leading.equalToSuperview().offset(padding)
        }
        
        mbtiI.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(mainTitlePadding)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        mbtiS.snp.makeConstraints { make in
            make.top.equalTo(mbtiE.snp.bottom).offset(buttonMargin)
            make.leading.equalToSuperview().offset(padding)
        }
        
        mbtiN.snp.makeConstraints { make in
            make.top.equalTo(mbtiE.snp.bottom).offset(buttonMargin)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        mbtiF.snp.makeConstraints { make in
            make.top.equalTo(mbtiN.snp.bottom).offset(buttonMargin)
            make.leading.equalToSuperview().offset(padding)
        }
        
        mbtiT.snp.makeConstraints { make in
            make.top.equalTo(mbtiN.snp.bottom).offset(buttonMargin)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
        mbtiP.snp.makeConstraints { make in
            make.top.equalTo(mbtiF.snp.bottom).offset(buttonMargin)
            make.leading.equalToSuperview().offset(padding)
        }
        
        mbtiJ.snp.makeConstraints { make in
            make.top.equalTo(mbtiF.snp.bottom).offset(buttonMargin)
            make.trailing.equalToSuperview().offset(-padding)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

import SwiftUI
#Preview {
    UserMBTIViewController()
}
