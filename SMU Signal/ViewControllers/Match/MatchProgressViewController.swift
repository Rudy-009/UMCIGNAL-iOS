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
    
    override func viewDidLoad() {
        waitingMode()
        setConstraints()
        navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
    }
    
    private func setConstraints() {
        self.view.backgroundColor = .white
        self.view.addSubview(gifImageView)
        self.view.addSubview(navigationBar)
        self.view.addSubview(stateLabel)
        
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
    }
    
    // UI
    private func waitingMode() {
        gifImageView.animate(withGIFNamed: "waiting")
        stateLabel.text = "작성해주신 정보를 바탕으로\nAI가 당신의 짝을 찾는중입니다."
    }
    
    private func failedMode() {
        gifImageView.animate(withGIFNamed: "failed")
        stateLabel.text = "찾는데 실패했습니다...\n다시 시도해주세요"
    }
    
    private func foundMode() {
        gifImageView.animate(withGIFNamed: "found")
        stateLabel.text = ""
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
    
}
