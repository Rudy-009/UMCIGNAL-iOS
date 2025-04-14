//
//  AgeButton.swift
//  SMU Signal
//
//  Created by 이승준 on 4/14/25.
//

import UIKit

class AgeButton: UIButton {
    
    public var isChecked: Bool = false
    public var agePrefered: Age?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addConstraints()
    }
    
    private func addConstraints() {
        self.clipsToBounds = true
        self.backgroundColor = .white
    }
    
    public func configure(_ agePrefered: Age) {
        self.agePrefered = agePrefered
        self.setImage(agePrefered.imageNonselected(), for: .normal)
    }
    
    public func checked() {
        self.setImage(agePrefered!.imageSelected(), for: .normal)
        isChecked = true
    }
    
    public func notChecked() {
        self.setImage(agePrefered!.imageNonselected(), for: .normal)
        isChecked = false
    }
    
    public func isMarked() -> Bool {
        return isChecked
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum Age: Int {
    case  younger = 1,
          same =  2,
          older = 3
    
    func imageNonselected() -> UIImage {
        switch self {
        case .same:
                .sameButton
        case .younger:
                .youngerButton
        case .older:
                .olderButton
        }
    }
    
    func imageSelected() -> UIImage {
        switch self {
        case .same:
                .sameButtonSelected
        case .younger:
                .youngerButtonSelected
        case .older:
                .olderButtonSelected
        }
    }
}

