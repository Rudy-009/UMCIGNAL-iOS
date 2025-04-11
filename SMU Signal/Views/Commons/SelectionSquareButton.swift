//
//  SelectionSquareButton.swift
//  UMCignal
//
//  Created by 이승준 on 4/5/25.
//

import UIKit

class SelectionSquareButton: UIButton {
    
    public var isChecked: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConstraints()
    }
    
    private func addConstraints() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.gray100.cgColor
    }
    
    public func checked() {
        self.backgroundColor = .TB_3
        self.layer.borderColor = UIColor.TB_2.cgColor
        isChecked = true
    }
    
    public func notChecked() {
        self.backgroundColor = .white
        self.layer.borderColor = UIColor.gray100.cgColor
        isChecked = false
    }
    
    public func isMarked() -> Bool {
        return isChecked
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
