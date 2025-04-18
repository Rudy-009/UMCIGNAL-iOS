//
//  RootVCService.swift
//  SMU Signal
//
//  Created by 이승준 on 4/16/25.
//

import UIKit

class RootViewControllerService {
    private static let sceneDelegate = UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate
    
    private static let homeVC = UINavigationController(rootViewController: HomeViewController())
    private static let networkErrorVC = NetworkErrorViewController()
    
    static func toLoginController() {
        sceneDelegate?.changeRootViewController(LoginFailedViewController(), animated: false)
    }
    
    static func toHomeViewController() {
        sceneDelegate?.changeRootViewController(homeVC, animated: false)
    }
    
    static func toIdealViewController() {
        sceneDelegate?.changeRootViewController(UINavigationController(rootViewController: IdealOnBoardingViewController()), animated: false)
    }
    
    static func toFixIdealViewController() {
        sceneDelegate?.changeRootViewController(UINavigationController(rootViewController: IdealAgeViewController()), animated: false)
    }
    
    static func toSignUpViewController() {
        sceneDelegate?.changeRootViewController(UINavigationController(rootViewController:  UserOnBoardingViewController()), animated: false)
    }
    
}
