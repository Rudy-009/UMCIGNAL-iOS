//
//  HomeView.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class HomeView: UIView {
    
    private let edgePadding: CGFloat = 24
    
    public lazy var gearButton = UIButton().then {
        $0.setImage(.gear, for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    private lazy var logoImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .umung
    }
    
    private lazy var userID = UILabel().then {
        $0.text = "@" + idElisipse("iseungjun401")
        $0.font = Fonts.H1
        $0.textColor = .white
    }
    
    private lazy var nimLabel = UILabel().then {
        $0.text = "님"
        $0.font = Fonts.H1
        $0.textColor = .TB_2
    }
    
    private lazy var subTitle = UILabel().then {
        $0.text = "스뮤 시그널에\n오신 것을 환영합니다."
        $0.font = Fonts.T2
        $0.textColor = .TB_2
        $0.numberOfLines = 2
    }
    
    private lazy var rerollFrame = UIView().then {
        $0.backgroundColor = .white
        $0.layer.cornerRadius = 26
        $0.clipsToBounds = true
    }
    
    private lazy var rerollCountLabel = UILabel().then {
        $0.backgroundColor = .TB
        $0.layer.cornerRadius = 15
        $0.clipsToBounds = true
        
        $0.font = Fonts.H1
        $0.textColor = .white
        $0.text = "10"
        $0.textAlignment = .center
        
        $0.snp.makeConstraints { make in
            make.width.equalTo(40)
            make.height.equalTo(30)
        }
    }
    
    private lazy var rerollLabel = UILabel().then {
        $0.text = "나의 남은 리롤 횟수"
        $0.font = Fonts.T2
    }
    
    private lazy var mainContentFrame = UIView().then {
        $0.backgroundColor = .white
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 32
        $0.layer.cornerCurve = .continuous
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    public lazy var matchResultButton = MatchResultButton()
    
    public lazy var editMyInfoButton = ResetButton()
    
    public lazy var idealMatchButton = ResetButton()
    
    public lazy var referralButton = ReferralButton()
    
    private lazy var redDot = UIView().then {
        $0.backgroundColor = .red400
        $0.layer.cornerRadius = 6
        $0.clipsToBounds = true
        $0.widthAnchor.constraint(equalToConstant: 12).isActive = true
        $0.heightAnchor.constraint(equalToConstant: 12).isActive = true
    }
    
    func setConstraints() {
        self.addSubview(gearButton)
        self.addSubview(logoImageView)
        self.addSubview(userID)
        self.addSubview(nimLabel)
        self.addSubview(subTitle)
        self.addSubview(rerollFrame)
        rerollFrame.addSubview(rerollCountLabel)
        rerollFrame.addSubview(rerollLabel)
        
        var logoSize: CGFloat = 160
        var gearSize: CGFloat = 60
        if UIScreen.main.bounds.width <= 375{
            logoSize = 140
            gearSize = 50
        }
        
        gearButton.snp.makeConstraints {
            $0.top.equalTo(safeAreaLayoutGuide)
            $0.trailing.equalToSuperview()
            $0.width.height.equalTo(gearSize)
        }
                
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(gearButton.snp.bottom)
            make.height.width.equalTo(logoSize)
            make.trailing.equalToSuperview().inset(edgePadding)
        }
        
        userID.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(edgePadding)
            make.centerY.equalTo(logoImageView).offset(-20)
        }
        
        nimLabel.snp.makeConstraints { make in
            make.centerY.equalTo(userID)
            make.leading.equalTo(userID.snp.trailing).offset(5)
        }
        
        subTitle.snp.makeConstraints { make in
            make.leading.equalTo(userID)
            make.top.equalTo(userID.snp.bottom).offset(5)
        }
        
        rerollFrame.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom)
            make.height.equalTo(52)
            make.leading.trailing.equalToSuperview().inset(edgePadding)
        }
        
        rerollCountLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(30)
        }
        
        rerollLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(rerollCountLabel.snp.trailing).offset(16)
        }
        setMainContentConstraints()
    }
    
    func setMainContentConstraints() {
        self.addSubview(mainContentFrame)
        mainContentFrame.addSubview(matchResultButton)
        mainContentFrame.addSubview(editMyInfoButton)
        mainContentFrame.addSubview(idealMatchButton)
        mainContentFrame.addSubview(referralButton)
        self.addSubview(redDot)
        
        // let frameHeight: CGFloat = mainContentFrame.frame.height
        let frameWidth: CGFloat = UIScreen.main.bounds.width
        let buttonWidth = (frameWidth - 55) / 2
        var buttonHeight: CGFloat = buttonWidth * ( 240.0 / 156.0 )
        
        mainContentFrame.snp.makeConstraints { make in
            make.top.equalTo(rerollFrame.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        if frameWidth <= 375 {
            let ratio = 1.4
            matchResultButton.setConstraints(width: buttonWidth, height: buttonWidth * ratio )
            matchResultButton.snp.makeConstraints { make in
                make.leading.top.equalToSuperview().inset(20)
            }
            
            redDot.snp.makeConstraints { make in
                make.trailing.top.equalTo(matchResultButton).inset(4)
            }
            
            editMyInfoButton.setConstraints(width: buttonWidth, height: (buttonWidth - 10.0) * (112.0/160.0))
            editMyInfoButton.configure(text: "내 매칭 정보 수정", image: .editIcon)
            editMyInfoButton.snp.makeConstraints { make in
                make.trailing.top.equalToSuperview().inset(20)
            }
            
            idealMatchButton.setConstraints(width: buttonWidth, height: (buttonWidth - 10.0) * (112.0/160.0))
            idealMatchButton.configure(text: "이상형 재설정", image: .palletIcon)
            idealMatchButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(20)
                make.top.equalTo(editMyInfoButton.snp.bottom).offset(10)
            }
           
        } else {
            let ratio =  240.0 / 156.0
            let editButtonHeight = (buttonHeight - 20.0) / 2.0
            
            matchResultButton.setConstraints(width: buttonWidth, height: buttonWidth * ratio )
            matchResultButton.snp.makeConstraints { make in
                make.leading.top.equalToSuperview().inset(20)
            }
            
            redDot.snp.makeConstraints { make in
                make.trailing.top.equalTo(matchResultButton).inset(4)
            }
            
            editMyInfoButton.setConstraints(width: buttonWidth, height: editButtonHeight)
            editMyInfoButton.configure(text: "내 매칭 정보 수정", image: .editIcon)
            editMyInfoButton.snp.makeConstraints { make in
                make.trailing.top.equalToSuperview().inset(20)
            }
            
            idealMatchButton.setConstraints(width: buttonWidth, height: editButtonHeight)
            idealMatchButton.configure(text: "이상형 재설정", image: .palletIcon)
            idealMatchButton.snp.makeConstraints { make in
                make.trailing.equalToSuperview().inset(20)
                make.top.equalTo(editMyInfoButton.snp.bottom).offset(20)
            }
        }
        
        referralButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(idealMatchButton.snp.bottom).offset(20)
        }
        
    }
    
    public func idElisipse(_ id: String) -> String {
        if id.count > 8 {
            let result = id.prefix(7)
            return "\(result)..."
        } else {
            return id
        }
    }
    
    public func showMatchAlarm() {
        redDot.isHidden = false
    }
    
    public func hideMatchAlarm() {
        redDot.isHidden = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .TB
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview {
    HomeViewController()
}
