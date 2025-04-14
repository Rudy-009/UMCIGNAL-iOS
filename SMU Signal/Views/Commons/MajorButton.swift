//
//  MajorButton.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class MajorButton: UIButton {
    
    public var major: String?
    
    public lazy var mainTitle = UILabel().then {
        $0.font = Fonts.B2
        $0.textColor = .black
    }
    
    public lazy var downArrow = UIImageView().then {
        $0.image = .downArrow
        $0.contentMode = .scaleAspectFit
    }
    
    func setTitle(text: String) {
        mainTitle.text = text
    }
    
    func setConstraints() {
        self.addSubview(mainTitle)
        self.addSubview(downArrow)
        
        self.snp.makeConstraints { make in
            make.height.equalTo(46)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(24)
            make.trailing.equalTo(downArrow.snp.leading).offset(10)
        }
        
        downArrow.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.height.width.equalTo(20)
            make.trailing.equalToSuperview().inset(24)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.layer.borderColor = UIColor.gray100.cgColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
