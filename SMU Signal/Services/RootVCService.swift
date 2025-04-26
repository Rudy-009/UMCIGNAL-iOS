//
//  RootVCService.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit

class RootViewControllerService {
    
    private static var sceneDelegate: SceneDelegate? {
        return UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    }
    
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
    
    static func toMatchViewController() {
        let vc = MatchViewController()
        vc.firstMatch()
        sceneDelegate?.changeRootViewController(UINavigationController(rootViewController: vc), animated: true)
    }
    
}
