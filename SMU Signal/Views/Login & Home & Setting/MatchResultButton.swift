//
//  MatchResultButton.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class MatchResultButton: UIButton {
    
    private lazy var mainTitle = UILabel().then {
        $0.text = "매칭 결과"
        $0.font = Fonts.H1
        $0.textColor = .white
    }
    
    private lazy var subTitle = UILabel().then {
        $0.text = "당신의 짝을 보고 싶을 때"
        $0.font = Fonts.Detail
        $0.textColor = .TB_2
    }
    
    private lazy var heartImage = UIImageView().then {
        $0.image = .twoHearts
        $0.isUserInteractionEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .TB
        self.layer.cornerRadius = 32
        self.clipsToBounds = true
    }
    
    public func setConstraints(width: CGFloat, height: CGFloat) {
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        self.addSubview(mainTitle)
        self.addSubview(subTitle)
        self.addSubview(heartImage)
        
        mainTitle.snp.makeConstraints { make in
            make.leading.top.equalToSuperview().offset(20)
        }
        
        subTitle.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.top.equalTo(mainTitle.snp.bottom).offset(4)
        }
        
        heartImage.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(20)
            make.bottom.equalToSuperview().offset(20)
        }
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


#Preview {
    HomeViewController()
}
