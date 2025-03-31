//
//  BottomConfirmButtonView.swift
//  ToYou
//
//  Created by 이승준 on 2/5/25.
//

import UIKit
import SnapKit
import Then

class ConfirmButton: UIButton {
    
    private lazy var mainLabel = UILabel().then {
        $0.text = "다음"
        $0.font = .systemFont(ofSize: 25)
        $0.textColor = .black
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.clipsToBounds = true
        self.layer.cornerRadius = 7
        self.backgroundColor = .gray
        self.isEnabled = false
        addComponents()
    }
    
    private func addComponents() {
        
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        self.addSubview(mainLabel)
        
        mainLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    public func configure(labelText: String) {
        mainLabel.text = labelText
    }
    
    public func availableForSendQuery() {
        mainLabel.textColor = .black
        self.backgroundColor = .gray
        self.isEnabled = true
    }
    
    public func available() {
        mainLabel.textColor = .black
        self.backgroundColor = .black
        self.isEnabled = true
    }
    
    public func unavailable() {
        mainLabel.textColor = .black
        self.backgroundColor = .gray
        self.isEnabled = false
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
