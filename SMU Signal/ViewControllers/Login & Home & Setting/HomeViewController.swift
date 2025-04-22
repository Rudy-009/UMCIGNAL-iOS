//
//  HomeViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate, RecommendationCodeModalViewDelegate {
    
    private let homeView = HomeView()
    private var recommendationCodeModal: RecommendationCodeModalViewController?
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.view = homeView
        setActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeView.setConstraints()
        setUI()
    }
    
    private func setActions() {
        homeView.gearButton.addTarget(self, action: #selector(goSettingVC), for: .touchUpInside)
        homeView.resetIdealType.addTarget(self, action: #selector(goIdealType), for: .touchUpInside)
        homeView.referralButton.addTarget(self, action: #selector(showRecommendationCodeModal), for: .touchUpInside)
        homeView.editMyInfoButton.addTarget(self, action: #selector(goEditMyInfo), for: .touchUpInside)
    }
    
    private func setUI() {
        // 1. 유저의 이름
        APIService.getInstagramId { id in
            self.homeView.setId(id)
        }
        
        // 2. 리롤 횟수
        APIService.getRerollCount { code in
            switch code {
            case .success:
                self.homeView.rerollCountLabel.text = String(Singletone.getReRollCount())
            case .expired, .missing, .error:
                RootViewControllerService.toLoginController()
            }
        }
        // 3. 사용자의 코드
    }
    
    @objc
    private func goEditMyInfo() {
        RootViewControllerService.toEditUserInfoViewController()
    }
    
    @objc
    private func goIdealType() {
        RootViewControllerService.toIdealViewController()
    }
    
    @objc
    private func goSettingVC() {
        let nextVC = SettingViewController()
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    // MARK: - 추천인 코드 모달 관련 메서드
    
    @objc
    private func showRecommendationCodeModal() {
        if recommendationCodeModal != nil {
            dismissModal()
        }
        recommendationCodeModal = RecommendationCodeModalViewController()
        guard let modalVC = recommendationCodeModal else { return }
        modalVC.delegate = self
        
        // 테스트용 추천인 코드 설정 (실제로는 API에서 가져올 것)
        modalVC.setMyRecommendationCode("f7fsd6f6fds7")
        
        if let sheetPresentationController = recommendationCodeModal?.sheetPresentationController {
            // 사용자 정의 detent 식별자 생성
            let customIdentifier = UISheetPresentationController.Detent.Identifier("customHeight")
            
            // 사용자 정의 높이 detent 생성
            let customDetent = UISheetPresentationController.Detent.custom(identifier: customIdentifier) { context in
                // 원하는 높이 반환 (포인트 단위)
                return 270 // 원하는 높이로 조정
            }
            
            sheetPresentationController.detents = [customDetent]
        }
        self.present(modalVC, animated: true, completion: nil)
    }
    
    private func dismissModal() {
        guard let modal = recommendationCodeModal else { return }
        
        modal.dismiss(animated: true) {
            self.recommendationCodeModal = nil
        }
    }
    
    // MARK: - RecommendationCodeModalViewDelegate
    
    func didTapConfirmButton(code: String) {
        // 추천인 코드 확인 버튼이 눌렸을 때의 동작
        // 여기서는 코드 확인만 하고, 실제 서버 요청은 나중에 구현
        
        // 적용된 경우
        self.recommendationCodeModal?.recView.codeAppliedMode()
        
        
        // 코드가 발견되지 않은 경우
        self.recommendationCodeModal?.recView.codeNotFoiundMode()
        
        // 일정 시간 후 모달 닫기 (실제로는 API 응답 후 닫기)
//        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
//            self.dismissModal()
//        }
    }
    
    func didTapCloseButton() {
        dismissModal()
    }
}

#Preview {
    UINavigationController(rootViewController: HomeViewController())
}
