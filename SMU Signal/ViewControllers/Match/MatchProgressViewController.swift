//
//  MatchProgressViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/23/25.
//

import UIKit
import Gifu

class MatchProgressViewController: UIViewController {
    
    let navigationBar = NavigationBarView()
    let gifImageView = GIFImageView()
    let stateLabel = UILabel().then {
        $0.font = Fonts.T1
        $0.numberOfLines = 2
        $0.textColor = .black
        $0.textAlignment = .center
    }
    let goToHomeButton = ConfirmButton()
    
    override func viewDidLoad() {
        waitingMode()
        setConstraints()
        navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        goToHomeButton.addTarget(self, action: #selector(goToHome), for: .touchUpInside)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.getMatch()
        }
    }
    
    func getMatch() {
        APIService.getReroll { (code, id) in
            switch code {
            case .success:
                self.foundMode()
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    let instaAppURL = URL(string: "instagram://user?username=\(id!)")
                    let instaWebURL = URL(string: "https://instagram.com/\(id!)")
                    if (UIApplication.shared.canOpenURL(instaAppURL! as URL)) {
                        UIApplication.shared.open(instaAppURL! as URL)
                    } else {
                        UIApplication.shared.open(instaWebURL! as URL)
                    }
                }
            case .expired:
                RootViewControllerService.toLoginController()
            case .nomore:
                self.navigationController?.popViewController(animated: true)
            case .failed:
                self.failedMode()
            case .error:
                self.persentNetwoekErrorAlert()
            }
        }
    }
    
    private func setConstraints() {
        self.view.backgroundColor = .white
        self.view.addSubview(gifImageView)
        self.view.addSubview(navigationBar)
        self.view.addSubview(stateLabel)
        self.view.addSubview(goToHomeButton)
        
        navigationBar.hideRightButton()
        
        navigationBar.snp.makeConstraints { make in
            make.leading.trailing.top.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        gifImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-100)
            make.centerX.equalToSuperview().offset(20)
            make.height.width.equalTo(300)
        }
        
        stateLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(gifImageView.snp.bottom).offset(20)
        }
        
        goToHomeButton.isHidden = true
        goToHomeButton.configure(labelText: "홈으로 이동")
        goToHomeButton.available()
        goToHomeButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    // UI
    private func waitingMode() {
        gifImageView.animate(withGIFNamed: "waiting")
        gifImageView.startAnimatingGIF()
        stateLabel.text = "작성해주신 정보를 바탕으로\nAI가 당신의 짝을 찾는중입니다."
    }
    
    private func failedMode() {
        if gifImageView.frameCount == 1 {
            gifImageView.stopAnimating()
        }
        gifImageView.animate(withGIFNamed: "failed")
        stateLabel.text = "찾는데 실패했습니다...\n다시 시도해주세요"
    }
    
    private func foundMode() {
        gifImageView.animate(withGIFNamed: "found")
        gifImageView.startAnimatingGIF()
        stateLabel.text = "매칭에 성공했습니다!!"
    }
    
    private func noMoreReroll() {
        gifImageView.animate(withGIFNamed: "failed")
        if gifImageView.frameCount == 1 {
            gifImageView.stopAnimating()
        }
        stateLabel.text = "리롤 기회를 모두 사용하셧습니다"
    }
    
    @objc
    private func goToHome() {
        RootViewControllerService.toHomeViewController()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    enum MatchingState: String {
        case failed, found, waiting
        
        func gifFileName() -> String {
            return self.rawValue
        }
    }
    
    public func firstMatch() {
        navigationBar.leftButton.isHidden = true
        goToHomeButton.isHidden = false
    }
    
}
