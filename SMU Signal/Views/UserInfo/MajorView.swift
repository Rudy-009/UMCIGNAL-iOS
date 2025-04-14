//
//  UserMajorView.swift
//  UMCignal
//
//  Created by 이승준 on 4/8/25.
//

import UIKit

class MajorView: UIView {
    
    public lazy var navigationBar = NavigationBarView()
    public lazy var progressBar = ProgressBar()
    private lazy var mainTitle = UILabel().then {
        $0.font = Fonts.H1
        $0.textColor = .black
        $0.textAlignment = .left
    }
    
    private lazy var subTitle = UILabel().then {
        $0.font = Fonts.B1
        $0.textColor = .black
        $0.textAlignment = .left
        $0.numberOfLines = 2
    }
    
    private lazy var buttonFrame = UIView()
    public lazy var collegeButton = MajorButton()
    public lazy var majorButton = MajorButton()
    
    public lazy var nextButton = ConfirmButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.setBasicConstraints()
    }
    
    public func configure(mainText: String, subText: String, progress: Float) {
        mainTitle.text = mainText
        subTitle.text = subText
        progressBar.progress = progress
    }
    
    private func setBasicConstraints() {
        self.addSubview(navigationBar)
        self.addSubview(progressBar)
        self.addSubview(mainTitle)
        self.addSubview(subTitle)
        self.addSubview(nextButton)
        
        navigationBar.hideRightButton()
        navigationBar.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.leading.trailing.equalToSuperview()
        }
        
        progressBar.snp.makeConstraints { make in
            make.top.equalTo(navigationBar.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        mainTitle.snp.makeConstraints { make in
            make.top.equalTo(progressBar.snp.bottom).offset(33)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        subTitle.snp.makeConstraints { make in
            make.top.equalTo(mainTitle.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(14)
        }
        
        nextButton.configure(labelText: "다음")
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(24)
        }
        
        self.addSubview(buttonFrame)
        buttonFrame.addSubview(collegeButton)
        buttonFrame.addSubview(majorButton)
        
        buttonFrame.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
            make.height.equalTo(40)
        }
        
        collegeButton.mainTitle.text = "단과대 선택"
        collegeButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).offset(-13)
        }
        
        majorButton.mainTitle.text = "학과 선택"
        majorButton.snp.makeConstraints { make in
            make.centerY.trailing.equalToSuperview()
            make.width.equalToSuperview().dividedBy(2).offset(-13)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// 단과대 Enum
enum College: String, Codable {
    case humanities = "인문사회과학대학"
    case education = "사범대학"
    case business = "경영경제대학"
    case engineering = "융합공과대학"
    case arts = "문화예술대학"

    func getValue() -> String {
        return self.rawValue
    }
}

// 학과 Enum
enum Major: String, Codable {
    // 인문사회과학대학
    case spaceEnvironment = "공간환경학부"
    case publicAdministration = "공공인재학부"
    case familyWelfare = "가족복지학과"
    case nationalSecurity = "국가안보학과"

    // 사범대학
    case koreanEducation = "국어교육과"
    case education = "교육학과"
    case englishEducation = "영어교육과"
    case mathEducation = "수학교육과"

    // 경영경제대학
    case financeEconomics = "경제금융학부"
    case businessAdministration = "경영학부"
    case globalBusiness = "글로벌경영학과"
    case integratedManagement = "융합경영학과"

    // 융합공과대학
    case smartIT = "휴먼지능정보공학전공"
    case fintechEngineering = "핀테크전공"
    case bigDataEngineering = "빅데이터융합전공"
    case smartProduction = "스마트생산전공"
    case animationDesign = "애니메이션전공"
    case computerEngineering = "컴퓨터과학전공"
    case electricalEngineering = "전기공학전공"
    case gameDesign = "게임전공"
    case iotIntegration = "지능IOT융합전공"
    case koreanContentDesign = "한일문화콘텐츠전공"
    case lifeScience = "생명화학전공"
    case energyChemistry = "화학에너지공학전공"
    case materialEngineering = "화공신소재전공"

    // 문화예술대학
    case foodNutritionDesign = "식품영양학전공"
    case fashionDesign = "의류학전공"
    case sportsHealthManagement = "스포츠건강관리전공"
    case danceArtsDesign = "무용예술전공"
    case lightingDesign = "조형예술전공"
    case livingArtsDesign = "생활예술전공"
    case musicDepartment = "음악학부"

    func getValue() -> String {
        return self.rawValue
    }
}


import SwiftUI
#Preview {
    UserMajorViewController()
}
