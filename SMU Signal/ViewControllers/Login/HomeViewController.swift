//
//  HomeViewController.swift
//  SMU Signal
//
//  Created by 이승준 on 4/15/25.
//

import UIKit

class HomeViewController: UIViewController {
    
    private let homeView = HomeView()
    
    override func viewDidLoad() {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.view = homeView
        homeView.setConstraints()
    }
    
}

#Preview {
    HomeViewController()
}
