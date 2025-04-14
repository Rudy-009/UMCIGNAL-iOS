//
//  UserMajorViewController.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class UserMajorViewController: UIViewController {
    
    private let majorView = MajorView()
    let nextVC = UserInstagramIDViewController()
    
    override func viewDidLoad() {
        self.view = majorView
        self.setButtonActions()
        self.setCollegeButtonAction()
        majorView.configure(mainText: "주전공 학과가 어디인가요?", subText: "학과 궁합도 알려드릴게요!", progress: 6.0/7.0)
    }
    
    private func setButtonActions() {
        majorView.navigationBar.leftButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        majorView.nextButton.addTarget(self, action: #selector(pushNextVC), for: .touchUpInside)
    }
    
    private func setCollegeButtonAction() {
        let allCollege: [College] = [.engineering, .humanities, .business, .arts, .education]
        var collegeActions: [UIAction] = []
        
        for college in allCollege {
            collegeActions.append(UIAction(title: college.rawValue, handler: {_ in
                self.majorView.collegeButton.configureCollege(college: college)
                self.majorView.nextButton.unavailable()
                // 1. 결과에 따라 학과 선택에 나올 내용도 달라져야함
                var majors: [Major] = []
                switch college {
                case .humanities:
                    majors = [
                        .spaceEnvironment, .publicAdministration, .familyWelfare, .nationalSecurity
                    ]
                case .education:
                    majors = [
                        .koreanEducation, .education, .englishEducation, .mathEducation
                    ]
                case .business:
                    majors = [
                        .financeEconomics, .businessAdministration, .globalBusiness, .integratedManagement
                    ]
                case .engineering:
                    majors = [ .smartIT, .fintechEngineering, .bigDataEngineering, .smartProduction,
                               .animationDesign, .computerEngineering, .electricalEngineering,
                               .gameDesign, .iotIntegration, .koreanContentDesign,
                               .lifeScience, .energyChemistry, .materialEngineering]
                case .arts:
                    majors = [ .foodNutritionDesign, .fashionDesign, .sportsHealthManagement,
                        .danceArtsDesign, .lightingDesign, .livingArtsDesign,
                        .musicDepartment
                    ]
                }
                self.setMajorAction(majors: majors)
                //2. 기존의 내용을 다시 default로 돌려야 함
                self.majorView.majorButton.mainTitle.text = "학과 선택"
                self.majorView.majorButton.major = nil
            }))
        }
        
        let menu = UIMenu(title: "", children: collegeActions)
        
        majorView.collegeButton.menu = menu
        majorView.collegeButton.showsMenuAsPrimaryAction = true
    }
    
    func setMajorAction(majors: [Major]) {
        var majorActions: [UIAction] = []
        for major in majors {
            majorActions.append(UIAction(title: major.rawValue, handler: {_ in
                self.majorView.majorButton.configureMajor(major)
                self.majorView.nextButton.available()
            }))
        }
        
        let menu = UIMenu(title: "", children: majorActions)
        
        majorView.majorButton.menu = menu
        majorView.majorButton.showsMenuAsPrimaryAction = true
    }
    
    @objc
    private func popVC() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc
    private func pushNextVC() {
        UserInfoSingletone.typeStudentMajor(majorView.majorButton.major!.rawValue)
        
        navigationController?.pushViewController(nextVC, animated: true)
    }
    
    private func isNextButtonAvailable() {
        if majorView.majorButton.isSelected {
            majorView.nextButton.available()
        }
    }
    
}
