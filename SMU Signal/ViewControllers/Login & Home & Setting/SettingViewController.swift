//
//  SettingViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit
import WebKit

class SettingViewController: UIViewController {
    
    private let settingView = SettingView()
    var url: URL?
    private var webView: WKWebView!
    
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
        if let url = URL(string: "https://makeus-challenge.notion.site/UMCignal-1bcb57f4596b803785d1c1870fd58088?pvs=4") {
            let modalVC = ModalViewController()
            modalVC.url = url
            modalVC.modalPresentationStyle = .pageSheet
            self.present(modalVC, animated: true, completion: nil)
        }
    }
    
    @objc
    private func showPrivacyPolicyWeb() {
        if let url = URL(string: "https://makeus-challenge.notion.site/UMCignal-1bcb57f4596b8006b1a3c4cdf165d5e1") {
            let modalVC = ModalViewController()
            modalVC.url = url
            modalVC.modalPresentationStyle = .pageSheet
            self.present(modalVC, animated: true, completion: nil)
        }
    }
    
    
    @objc
    private func logout() {
        APIService.out("logOut")
    }
    
    @objc
    private func revoke() {
        APIService.out("signOut")
    }
}

// ModalViewController 구현
class ModalViewController: UIViewController {
    var url: URL?
    private var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView(frame: self.view.bounds)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(webView)
        if let url = url {
            webView.load(URLRequest(url: url))
        }
    }
}

#Preview {
    SettingViewController()
}
