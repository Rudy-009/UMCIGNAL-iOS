//
//  AlcoholCapabilityButton.swift
//  UMCignal
//
//  Created by 이승준 on 4/10/25.
//

import UIKit

class AlcoholCapabilityButton: UIButton {
    
    public var isChecked: Bool = false
    public var alcohol: AlcoholEnum?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConstraints()
    }
    
    private func addConstraints() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = .white
    }
    
    public func configure(_ alcohol: AlcoholEnum) {
        self.alcohol = alcohol
        self.setImage(alcohol.imageNonselected(), for: .normal)
    }
    
    public func checked() {
        self.setImage(alcohol!.imageSelected(), for: .normal)
        isChecked = true
    }
    
    public func notChecked() {
        self.setImage(alcohol!.imageNonselected(), for: .normal)
        isChecked = false
    }
    
    public func isMarked() -> Bool {
        return isChecked
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum AlcoholEnum {
    case glass, aBottle, bottles
    
    func toResponse() -> Int {
        switch self {
        case .glass:
            return 0
        case .aBottle:
            return 1
        case .bottles:
            return 2
        }
    }
    
    func imageNonselected() -> UIImage {
        switch self {
        case .glass:
            return .glassButton
        case .aBottle:
            return .aBottleButton
        case .bottles:
            return .bottlesButton
        }
    }
    
    func imageSelected() -> UIImage {
        switch self {
        case .glass:
            return .glassButtonSelected
        case .aBottle:
            return .aBottleButtonSelected
        case .bottles:
            return .bottlesButtonSelected
        }
    }
}

