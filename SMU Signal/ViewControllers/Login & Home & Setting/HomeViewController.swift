//
//  HomeViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class HomeViewController: UIViewController, UIGestureRecognizerDelegate, RecommendationCodeModalViewDelegate {
    
    private let homeView = HomeView()
    private var recommendationCodeModal: ReferralViewController?
    
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        self.view = homeView
        setActions()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        homeView.setConstraints()
        homeView.hideMatchAlarm()
        fetchData()
        APIService.getReferralCode{ code in
            switch code {
            case .success:
                break
            case .error:
                self.persentNetworkErrorAlert()
            case .expired:
                RootViewControllerService.toLoginController()
            default:
                self.persentNetworkErrorAlert()
            }
        }
    }
    
    private func setActions() {
        homeView.gearButton.addTarget(self, action: #selector(goSettingVC), for: .touchUpInside)
        homeView.resetIdealType.addTarget(self, action: #selector(goIdealType), for: .touchUpInside)
        homeView.referralButton.addTarget(self, action: #selector(showRecommendationCodeModal), for: .touchUpInside)
        homeView.editMyInfoButton.addTarget(self, action: #selector(goEditMyInfo), for: .touchUpInside)
        homeView.matchResultButton.addTarget(self, action: #selector(goMatch), for: .touchUpInside)
    }
    
    private func fetchData() {
        // 1. 유저의 이름
        APIService.getInstagramId { id, code  in
            switch code {
            case .success:
                self.homeView.setId(id)
            case .error:
                self.persentNetworkErrorAlert()
            case .expired:
                RootViewControllerService.toLoginController()
            case .missing:
                break
            }
        }
        
        // 2. 리롤 횟수
        APIService.getRerollCount { code in
            switch code {
            case .success:
                self.homeView.rerollCountLabel.text = String(Singletone.getReRollCount())
            case .expired, .missing:
                RootViewControllerService.toLoginController()
            case .error:
                self.persentNetworkErrorAlert()
            }
        }
    }
    
    @objc
    private func goMatch() {
        let matchVC = MatchViewController()
        navigationController?.pushViewController(matchVC, animated: true)
    }
    
    @objc
    private func goEditMyInfo() {
        RootViewControllerService.toEditUserInfoViewController()
    }
    
    @objc
    private func goIdealType() {
        RootViewControllerService.toFixIdealViewController()
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
        recommendationCodeModal = ReferralViewController()
        guard let modalVC = recommendationCodeModal else { return }
        modalVC.delegate = self
        
        if let sheetPresentationController = recommendationCodeModal?.sheetPresentationController {
            let customIdentifier = UISheetPresentationController.Detent.Identifier("customHeight")
            let customDetent = UISheetPresentationController.Detent.custom(identifier: customIdentifier) { context in
                return 270
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
        if code.count == 6 {
            APIService.useReferralCode(code: code) { code, message  in
                switch code {
                case .success:
                    self.recommendationCodeModal?.recView.successedMode()
                case .notLogined, .expired:
                    RootViewControllerService.toLoginController()
                case .notFound:
                    self.recommendationCodeModal?.recView.notFoundCodeMode()
                case .alreadyUsed:
                    self.recommendationCodeModal?.recView.alreadyUsedCodeMode()
                case .error:
                    self.recommendationCodeModal?.recView.referralErrorMode()
                }
            }
        } else if code.count == 8 {
            APIService.useSerialCode(code: code) { code, message  in
                switch code {
                case .success:
                    self.recommendationCodeModal?.recView.successedMode()
                case .alreadyUsed:
                    self.recommendationCodeModal?.recView.alreadyUsedCodeMode()
                case .exporedToken:
                    self.recommendationCodeModal?.recView.expiredTokenMode()
                case .expired:
                    RootViewControllerService.toLoginController()
                case .notFound:
                    self.recommendationCodeModal?.recView.notFoundCodeMode()
                case .error:
                    self.recommendationCodeModal?.recView.serialCodeErrorMode()
                }
            }
        }
        fetchData()
        
    }
    
    func didTapCloseButton() {
        dismissModal()
    }
}
