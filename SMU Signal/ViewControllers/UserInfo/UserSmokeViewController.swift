//
//  SmokeSelectionViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit
import Combine

class UserSmokeViewController: UIViewController {
    
    private let userSmokeView = SmokeView()
    let nextVC = UserAlcoholViewController()
    
    // Combine 관련 프로퍼티 추가
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        self.view = userSmokeView
        self.setButtonActions()
        userSmokeView.configure(mainText: "흡연 하시나요?", subText: "서로 흡연에 대한 생각이 같은 분들과 \n매칭해드릴게요.", progress: 3.0/7.0)
        // Combine을 사용하여 흡연 상태 변경 감지
        setupCombineSubscriptions()
    }
    
    private func setupCombineSubscriptions() {
        // UserInfoSingletone.smokingSubject를 구독하여 상태 변화 감지
        UserInfoSingletone.smokingSubject
            .receive(on: RunLoop.main)
            .sink { [weak self] isSmoking in
                guard let self = self else { return }
                guard let isSmoking = isSmoking else { return }
                
                if isSmoking {
                    self.userSmokeView.smokerButton.checked()
                    self.userSmokeView.nonSmokerButton.notChecked()
                } else {
                    self.userSmokeView.nonSmokerButton.checked()
                    self.userSmokeView.smokerButton.notChecked()
                }
                
                // 버튼이 선택되었으므로 다음 버튼 활성화
                self.userSmokeView.nextButton.available()
            }
            .store(in: &cancellables)
        
        // SmokeButton의 체크 상태 변화 감지
        userSmokeView.smokerButton.checkedPublisher
            .receive(on: RunLoop.main)
            .filter { $0 == true } // 체크된 경우만 처리
            .sink { [weak self] _ in
                guard let self = self else { return }
                // 흡연자 버튼이 체크되면 비흡연자 버튼은 체크 해제
                self.userSmokeView.nonSmokerButton.notChecked()
                // UserInfo 모델 업데이트
                UserInfoSingletone.typeIsSmoking(true)
                // 다음 버튼 활성화
                self.userSmokeView.nextButton.available()
            }
            .store(in: &cancellables)
        
        userSmokeView.nonSmokerButton.checkedPublisher
            .receive(on: RunLoop.main)
            .filter { $0 == true } // 체크된 경우만 처리
            .sink { [weak self] _ in
                guard let self = self else { return }
                // 비흡연자 버튼이 체크되면 흡연자 버튼은 체크 해제
                self.userSmokeView.smokerButton.notChecked()
                // UserInfo 모델 업데이트
                UserInfoSingletone.typeIsSmoking(false)
                // 다음 버튼 활성화
                self.userSmokeView.nextButton.available()
            }
            .store(in: &cancellables)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userSmokeView.setButtonConstraints()
        // Combine으로 구현했으므로 이 부분은 필요 없지만, 초기 로드 시에는 값을 가져와서 UI에 설정
        if let isSmoker = UserInfoSingletone.shared.is_smoking {
            // 이미 Combine 구독에서 처리되므로 여기서는 재발행
            UserInfoSingletone.smokingSubject.send(isSmoker)
        }
    }
    
    private func setButtonActions() {
        userSmokeView.smokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        userSmokeView.nonSmokerButton.addTarget(self, action: #selector(handleButtonTapped(_:)), for: .touchUpInside)
        userSmokeView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        userSmokeView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
    }
    
    @objc
    private func handleButtonTapped(_ sender: SmokeButton) {
        sender.checked()
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        UserInfoSingletone.typeIsSmoking(userSmokeView.smokerButton.isChecked)
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func isNextButtonAvailable() {
        let buttons = [userSmokeView.smokerButton, userSmokeView.nonSmokerButton]
        for button in buttons {
            if button.isMarked() {
                userSmokeView.nextButton.available()
            }
        }
    }
    
}

