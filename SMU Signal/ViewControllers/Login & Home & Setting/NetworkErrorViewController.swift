//
//  NetworkErrorViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit

class NetworkErrorViewController: UIViewController {
    
    private let mainTitle = UILabel().then {
        $0.text = "서버 에러가 발생했어요\n인터넷 연결을 확인해주세요"
        $0.textAlignment = .center
        $0.numberOfLines = 2
        $0.font = Fonts.H1
    }
    
    public lazy var refreshButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
        $0.contentMode = .scaleAspectFit
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-100)
        }
        
        self.view.addSubview(refreshButton)
        
        refreshButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainTitle.snp.bottom).offset(20)
            make.height.width.equalTo(200)
        }
        
        refreshButton.addTarget(self, action: #selector(refresh), for: .touchUpInside)
    }
    
    @objc
    private func refresh() {
        APIService.checkToken { code in
            switch code {
            case .success:
                self.dismiss(animated: true)
            case .expired:
                RootViewControllerService.toLoginController()
            case .idealNotCompleted:
                self.dismiss(animated: true)
            case .signupNotCompleted:
                self.dismiss(animated: true)
            case .error:
                break
            }
        }
    }
    
}
