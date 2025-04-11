//
//  UILabels.swift
//  UMCignal
//
//  Created by 이승준 on 4/6/25.
//

import UIKit

class LabelComponents {
    
    static let H1Label = UILabel().then {
        $0.font = Fonts.H1
        $0.textColor = .black
        $0.text = " "
    }
    
    static let T1Label = UILabel().then {
        $0.font = Fonts.T1
        $0.textColor = .black
        $0.text = " "
    }
    
    static let T2Label = UILabel().then {
        $0.font = Fonts.T2
        $0.textColor = .black
        $0.text = " "
    }
    
    static let B1Label = UILabel().then {
        $0.font = Fonts.B1
        $0.textColor = .black
        $0.text = " "
    }
    
    static let B2Label = UILabel().then {
        $0.font = Fonts.B2
        $0.textColor = .black
        $0.text = " "
    }
    
    static let B3Label = UILabel().then {
        $0.font = Fonts.B3
        $0.textColor = .black
        $0.text = " "
    }
    
    static let DetailLabel = UILabel().then {
        $0.font = Fonts.Detail
        $0.textColor = .black
        $0.text = " "
    }

}
