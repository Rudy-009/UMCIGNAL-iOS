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
    
    // 공통 함수로 root ViewController 변경 로직 통합
    private static func changeRootViewController(_ viewControllerFactory: () -> UIViewController) {
        DispatchQueue.main.async {
            let viewController = viewControllerFactory()
            
            // 메모리 누수 방지를 위해 이전 루트 뷰 컨트롤러 참조 저장
            let oldRootVC = sceneDelegate?.window?.rootViewController
            
            // 새 루트 뷰 컨트롤러로 변경
            sceneDelegate?.changeRootViewController(viewController, animated: false)
            
            // 이전 뷰 컨트롤러 참조 정리
            oldRootVC?.view = nil
            oldRootVC?.removeFromParent()
        }
    }
    
    static func toLoginController() {
        changeRootViewController { LoginFailedViewController() }
    }
    
    static func toHomeViewController() {
        changeRootViewController {
            UINavigationController(rootViewController: HomeViewController())
        }
    }
    
    static func toIdealViewController() {
        changeRootViewController {
            UINavigationController(rootViewController: IdealOnBoardingViewController())
        }
    }
    
    static func toFixIdealViewController() {
        changeRootViewController {
            UINavigationController(rootViewController: IdealAgeViewController())
        }
    }
    
    static func toSignUpViewController() {
        changeRootViewController {
            UINavigationController(rootViewController: UserOnBoardingViewController())
        }
    }
}
