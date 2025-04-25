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
        $0.font = Fonts.H1
    }
    
    public lazy var refreshButton = UIButton().then {
        $0.setImage(UIImage(systemName: "arrow.clockwise"), for: .normal)
    }
    
    override func viewDidLoad() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(mainTitle)
        
        mainTitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
}
