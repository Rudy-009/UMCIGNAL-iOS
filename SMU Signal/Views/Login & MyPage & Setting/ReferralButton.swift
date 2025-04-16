//
//  ReferralButton.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit

class ReferralButton: UIButton {
    
    private lazy var mainTitle = UILabel().then {
        $0.text = "Event 1."
        $0.font = UIFont(name: "Pretendard-Bold", size: 16)
        $0.textColor = .white
        $0.isUserInteractionEnabled = false
    }
    
    private lazy var subTitle = UILabel().then {
        $0.text = "추천인 코드로 매칭 한 번 더?"
        $0.isUserInteractionEnabled = false
        $0.font = Fonts.B3
        $0.textColor = .white
    }
    
    private lazy var contentLabel = UILabel().then {
        $0.text = "친구의 추천인 코드를 입력하면\n이상형을 새로고침할 수 있습니다."
        $0.isUserInteractionEnabled = false
        $0.font = Fonts.Detail
        $0.numberOfLines = 2
        $0.textColor = .P_2
    }
    
    private lazy var image = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = .gift
        $0.isUserInteractionEnabled = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .P
        self.layer.cornerRadius = 32
        self.clipsToBounds = true
        self.snp.makeConstraints { make in
            make.height.equalTo(108)
        }
        setConstraints()
    }
    
    private func setConstraints() {
        let leadingPadding: CGFloat = 20
        
        self.addSubview(mainTitle)
        self.addSubview(subTitle)
        self.addSubview(contentLabel)
        self.addSubview(image)
        
        subTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(leadingPadding)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.bottom.equalTo(subTitle.snp.top).offset(-5)
            make.leading.equalToSuperview().offset(leadingPadding)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(subTitle.snp.bottom).offset(5)
            make.leading.equalToSuperview().offset(leadingPadding)
        }
        
        image.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.trailing.equalToSuperview().offset(-leadingPadding)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


#Preview {
    HomeViewController()
}
