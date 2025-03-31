//
//  UserInfoViewController.swift
//  UMCignal
//
//  Created by 이승준 on 3/31/25.
//

import UIKit

class UserInfoViewController: UIViewController {
    
    private let userInfoView = UserInfoView()
    
    override func viewDidLoad() {
        self.view = userInfoView
    }
    
}

import SwiftUI
#Preview {
    UserInfoViewController()
}
