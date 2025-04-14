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
        self.contentMode = .scaleAspectFill
    }
    
    public func configure(_ mbti: MBTIEnum) {
        self.mbti = mbti
        self.setImage(mbti.image(), for: .normal)
    }
    
    public func checked() {
        self.setImage(self.mbti!.selectedImage(), for: .normal)
        isChecked = true
    }
    
    public func notChecked() {
        self.setImage(self.mbti!.image(), for: .normal)
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
    
    func image() -> UIImage {
        switch self {
        case .i:
            return .iButton
        case .e:
            return .eButton
        case .n:
            return .nButton
        case .s:
            return .sButton
        case .f:
            return .fButton
        case .t:
            return .tButton
        case .p:
            return .pButton
        case .j:
            return .jButton
        }
    }
    
    func selectedImage() -> UIImage {
        switch self {
        case .i:
            return .iButtonSelected
        case .e:
            return .eButtonSelected
        case .n:
            return .nButtonSelected
        case .s:
            return .sButtonSelected
        case .f:
            return .fButtonSelected
        case .t:
            return .tButtonSelected
        case .p:
            return .pButtonSelected
        case .j:
            return .jButtonSelected
        }
    }
}
