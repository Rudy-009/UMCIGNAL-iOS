//
//  UserSmokeSelectionButton.swift
//  UMCignal
//
//  Created by 이승준 on 4/10/25.
//

import UIKit
import Combine

class SmokeButton: UIButton {
    
    public var isChecked: Bool = false {
        didSet {
            // isChecked가 변경될 때 publisher를 통해 이벤트 발행
            checkedPublisher.send(isChecked)
        }
    }
    public var isSmoke: Smoke?
    
    // 버튼 체크 상태를 발행하는 publisher
    public let checkedPublisher = PassthroughSubject<Bool, Never>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        // self.isUserInteractionEnabled = false
        self.addConstraints()
    }
    
    private func addConstraints() {
        self.layer.cornerRadius = 8
        self.clipsToBounds = true
        self.backgroundColor = .white
    }
    
    public func configure(_ isSmoke: Smoke) {
        self.isSmoke = isSmoke
        self.setImage(isSmoke.imageNonselected(), for: .normal)
    }
    
    public func checked() {
        self.setImage(isSmoke!.imageSelected(), for: .normal)
        isChecked = true
    }
    
    public func notChecked() {
        self.setImage(isSmoke!.imageNonselected(), for: .normal)
        isChecked = false
    }
    
    public func isMarked() -> Bool {
        return isChecked
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

enum Smoke {
    case none, smoker
    
    func toResponse() -> Bool {
        switch self {
        case .none:
            return false
        case .smoker:
            return true
        }
    }
    
    func imageNonselected() -> UIImage {
        switch self {
        case .none:
            return .nonSmokerButton
        case .smoker:
            return .smokerButton
        }
    }
    
    func imageSelected() -> UIImage {
        switch self {
        case .none:
            return .nonSmokerSelected
        case .smoker:
            return .smokerSelected
        }
    }
}
