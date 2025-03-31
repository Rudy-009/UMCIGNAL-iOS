//
//  UITextField.swift
//  UMCignal
//
//  Created by 이승준 on 3/31/25.
//

import UIKit

extension UITextField {
    
    func setPlaceholder(text: String, color: UIColor) {
        self.attributedPlaceholder = NSAttributedString(
            string: text,
            attributes: [
                .foregroundColor: color
            ])
    }
    
}
