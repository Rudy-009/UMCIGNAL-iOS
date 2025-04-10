//
//  MBTIButton.swift
//  UMCignal
//
//  Created by 이승준 on 4/11/25.
//

import UIKit

class MBTIButton: UIButton {
    
    public var isChecked: Bool = false
    public var mbti: MBTIEnum?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConstraints()
    }
    
    private func addConstraints() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = .white
        self.layer.borderWidth = 2
        self.layer.borderColor = UIColor.gray100.cgColor
    }
    
    public func configure(_ mbti: MBTIEnum) {
        self.mbti = mbti
        self.setTitle(mbti.getValue(), for: .normal)
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

enum MBTIEnum {
    case i, e, n, s, f, t, p, j
    
    func getValue() -> String {
        switch self {
        case .i:
            return "I"
        case .e:
            return "E"
        case .n:
            return "N"
        case .s:
            return "S"
        case .f:
            return "F"
        case .t:
            return "T"
        case .p:
            return "P"
        case .j:
            return "J"
        }
    }
}
