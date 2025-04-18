//
//  BinaryButton.swift
//  SMU Signal
//
//  Created by 이승준 on 4/18/25.
//

import UIKit

class YesNoButton: UIButton {
    public var isChecked: Bool = false
    public var yesNo: YesNo?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConstraints()
    }
    
    private func addConstraints() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = .white
    }
    
    public func configure(_ yesNo: YesNo) {
        self.yesNo = yesNo
        self.setImage(yesNo.imageNonselected(), for: .normal)
    }
    
    public func checked() {
        self.setImage(yesNo!.imageSelected(), for: .normal)
        isChecked = true
    }
    
    public func notChecked() {
        self.setImage(yesNo!.imageNonselected(), for: .normal)
        isChecked = false
    }
    
    public func isMarked() -> Bool {
        return isChecked
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum YesNo {
    case yes, no
    
    func toResponse() -> Int {
        switch self {
        case .no:
            return 0
        case .yes:
            return 1
        }
    }
    
    func imageNonselected() -> UIImage {
        switch self {
        case .no:
            return .noButton
        case .yes:
            return .yesButton
        }
    }
    
    func imageSelected() -> UIImage {
        switch self {
        case .no:
            return .noButtonSelected
        case .yes:
            return .yesButtonSelected
        }
    }
}


#Preview {
    IdealMajorViewController()
}
