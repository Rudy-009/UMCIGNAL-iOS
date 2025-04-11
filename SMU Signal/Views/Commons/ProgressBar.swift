//
//  ProgressBar.swift
//  UMCignal
//
//  Created by 이승준 on 4/5/25.
//

import UIKit

class ProgressBar: UIProgressView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.progress = 0
        self.trackTintColor = .gray100
        self.progressTintColor = .TB
        
        self.layer.cornerRadius = 4
        self.clipsToBounds = true
        self.snp.makeConstraints { make in
            make.height.equalTo(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
