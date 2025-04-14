//
//  GenderButton.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class GenderButton: UIButton {
    
    public var isChecked: Bool = false
    public var gender: Gender?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConstraints()
    }
    
    private func addConstraints() {
        self.contentMode = .scaleAspectFill
    }
    
    public func configure(_ gender: Gender) {
        self.gender = gender
        self.setImage(gender.image(), for: .normal)
    }
    
    public func checked() {
        self.setImage(self.gender!.selectedImage(), for: .normal)
        isChecked = true
    }
    
    public func notChecked() {
        self.setImage(self.gender!.image(), for: .normal)
        isChecked = false
    }
    
    public func isMarked() -> Bool {
        return isChecked
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum Gender: String, Codable {
    case male, female, other
    
    func getValue() -> String {
        switch self {
        case .male:
            return "male"
        case .female:
            return "female"
        case .other:
            return "other"
        }
    }
    
    func image() -> UIImage? {
        switch self {
        case .male:
            return .maleButton
        case .female:
            return .femaleButton
        case .other:
            return .otherButton
        }
    }
    
    func selectedImage() -> UIImage? {
        switch self {
        case .male:
            return .maleButtonSelected
        case .female:
            return .femaleButtonSelected
        case .other:
            return .otherButtonSelected
        }
    }
}
