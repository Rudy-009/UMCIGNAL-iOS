//
//  NavigationBarView.swift
//  UMCignal
//
//  Created by 이승준 on 3/31/25.
//

import UIKit

public class NavigationBarView: UIView {
    
    public lazy var leftButton = UIButton().then {
        $0.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    
    public lazy var rightButton = UIButton().then {
        $0.setImage(UIImage(systemName: "xmark"), for: .normal)
        $0.contentMode = .scaleAspectFit
        $0.tintColor = .black
    }
    
    public lazy var titleLabel = UILabel().then {
        $0.textColor = .black
    }
    
    private func setConstraints() {
        self.snp.makeConstraints { make in
            make.height.equalTo(80)
        }
        
        self.addSubview(leftButton)
        self.addSubview(titleLabel)
        self.addSubview(rightButton)
        
        leftButton.snp.makeConstraints { make in
            // make.
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
