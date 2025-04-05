//
//  NavigationBarView.swift
//  UMCignal
//
//  Created by 이승준 on 3/31/25.
//

import UIKit

public class NavigationBarView: UIView {
    
    public lazy var leftButton = UIButton().then {
        $0.setImage(.rightArrow, for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    
    public lazy var rightButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    
    public lazy var titleLabel = LabelComponents.T1Label
    
    private func setConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(50)
        }
        
        self.addSubview(leftButton)
        self.addSubview(titleLabel)
        self.addSubview(rightButton)
        
        leftButton.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.centerY.leading.equalToSuperview()
        }
        
        leftButton.imageView?.snp.makeConstraints { make in
            make.height.equalTo(16)
            make.width.equalTo(8)
        }
        
        rightButton.snp.makeConstraints { make in
            make.height.width.equalTo(60)
            make.centerY.trailing.equalToSuperview()
        }
        
        rightButton.imageView?.snp.makeConstraints { make in
            make.height.width.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    public func configure(text: String) {
        titleLabel.text = text
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
