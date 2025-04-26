//
//  CheckBoxButton.swift
//  SMU Signal
//
//  Created by 이승준 on 4/27/25.
//

import UIKit

class CheckBoxButton: UIButton {
    
    public var isChecked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConstraints()
    }
    
    private func addConstraints() {
        self.clipsToBounds = true
        self.backgroundColor = .white
        
        self.imageView?.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
    
    public func configure(_ isChecked: Bool) {
        self.isChecked = isChecked
        self.setImage(isChecked ? .checked : .unchecked , for: .normal)
    }
    
    public func checked() {
        self.setImage(.checked , for: .normal)
        self.isChecked = true
    }
    
    public func notChecked() {
        self.setImage(.unchecked, for: .normal)
        self.isChecked = false
    }
    
    public func isMarked() -> Bool {
        return self.isChecked
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
