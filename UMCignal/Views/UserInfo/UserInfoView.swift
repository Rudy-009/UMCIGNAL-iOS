//
//  UserInfoView.swift
//  UMCignal
//
//  Created by 이승준 on 3/31/25.
//

import UIKit

class UserInfoView: UIView {
    
    public lazy var navigationBar = NavigationBarView()
    public lazy var progressBar = UIProgressView().then {
        $0.backgroundColor = .gray
        $0.layer.cornerRadius = 5
        $0.clipsToBounds = true
    }
    public lazy var confirmButton = ConfirmButton()
    
    private func setConstraints() {
        self.backgroundColor = .white
        self.addSubview(navigationBar)
        
        navigationBar.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(self.safeAreaLayoutGuide)
        }
        
        self.addSubview(progressBar)
        progressBar.setProgress(0.4, animated: true)
        progressBar.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.height.equalTo(10)
            make.top.equalTo(navigationBar.snp.bottom).offset(10)
        }
        
        self.addSubview(confirmButton)
        confirmButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-20)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

import SwiftUI
#Preview {
    UserInfoViewController()
}
