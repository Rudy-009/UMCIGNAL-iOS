//
//  resetButton.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class ResetButton: UIButton {
    
    private lazy var mainTitle = UILabel().then {
        $0.font = Fonts.H1
        $0.textColor = .black
    }
    
    private lazy var mainImage = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.isUserInteractionEnabled = false
    }
    
    func setConstraints(width: CGFloat, height: CGFloat) {
        self.snp.makeConstraints { make in
            make.height.equalTo(height)
            make.width.equalTo(width)
        }
        
        if width <= 180 {
            mainTitle.font = UIFont(name: "Pretendard-Bold", size: 16)
        }
        
        self.addSubview(mainTitle)
        self.addSubview(mainImage)
        
        mainTitle.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(width/8.0)
            make.top.equalToSuperview().offset(height/5.1)
        }
        
        mainImage.snp.makeConstraints { make in
            make.width.height.equalTo(height * (60.0/112.0))
            make.trailing.equalToSuperview().inset(width/16.0)
            make.bottom.equalToSuperview().inset(width/16.0)
        }
    }
    
    func configure(text: String, image: UIImage) {
        mainTitle.text = text
        mainImage.image = image
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 32
        self.clipsToBounds = true
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray100.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

#Preview {
    HomeViewController()
}
