//
//  RootVCService.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit

class RootViewControllerService {
    // 매번 호출 시 현재 SceneDelegate를 가져오는 계산 속성
    private static var sceneDelegate: SceneDelegate? {
        return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }
    
//    // 공통 함수로 root ViewController 변경 로직 통합
//    private static func changeRootViewController(_ viewControllerFactory: () -> UIViewController) {
//        DispatchQueue.main.async {
//            let viewController = viewControllerFactory()
//            
//            // 메모리 누수 방지를 위해 이전 루트 뷰 컨트롤러 참조 저장
//            let oldRootVC = sceneDelegate?.window?.rootViewController
//            
//            // 새 루트 뷰 컨트롤러로 변경
//            sceneDelegate?.changeRootViewController(viewController, animated: false)
//            
//            // 이전 뷰 컨트롤러 참조 정리
//            oldRootVC?.view = nil
//            oldRootVC?.removeFromParent()
//        }
//    }
    
    static func toLoginController() {
        sceneDelegate?.changeRootViewController(LoginFailedViewController(), animated: true)
    }
    
    static func toHomeViewController() {
        sceneDelegate?.changeRootViewController(UINavigationController(rootViewController: HomeViewController()), animated: true)
    }
    
    static func toIdealViewController() {
        sceneDelegate?.changeRootViewController(UINavigationController(rootViewController: IdealOnBoardingViewController()), animated: true)
    }
    
    static func toFixIdealViewController() {
        let vc = IdealAgeViewController()
        vc.isRoot = true
        sceneDelegate?.changeRootViewController(UINavigationController(rootViewController: vc), animated: true)
    }
    
    static func toEditUserInfoViewController() {
        sceneDelegate?.changeRootViewController(UINavigationController(rootViewController: EditSmokingViewController()), animated: true)
    }
    
    static func toSignUpViewController() {
        sceneDelegate?.changeRootViewController(UINavigationController(rootViewController: UserOnBoardingViewController()), animated: true)
    }
}
