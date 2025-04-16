//
//  SettingViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit

class SettingViewController: UIViewController {
    
    private let settingView = SettingView()
    
    override func viewDidLoad() {
        self.view = settingView
        setActions()
    }
    
    private func setActions() {
        settingView.popButton.addTarget(self, action: #selector(pop), for: .touchUpInside)
        settingView.termOfUseButton.addTarget(self, action: #selector(showTermsOfServiceWeb), for: .touchUpInside)
        settingView.privacyPolicyButton.addTarget(self, action: #selector(showPrivacyPolicyWeb), for: .touchUpInside)
        settingView.logout.addTarget(self, action: #selector(logout), for: .touchUpInside)
        settingView.revoke.addTarget(self, action: #selector(revoke), for: .touchUpInside)
    }
    
    @objc
    private func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func showTermsOfServiceWeb() {
        print("showTermsOfServiceWeb")
    }
    
    @objc
    private func showPrivacyPolicyWeb() {
        print("showPrivacyPolicyWeb")
    }
    
    @objc
    private func logout() {
        print("logout")
    }
    
    @objc
    private func revoke() {
        print("revoke")
    }
}

#Preview {
    SettingViewController()
}
