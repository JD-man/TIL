//
//  ViewController.swift
//  Firebase_Analytics
//
//  Created by JD_MacMini on 2021/12/06.
//

import UIKit
import Firebase
import FirebaseAnalytics

class ViewController: UIViewController {
    
    let button: UIButton = {
        let button = UIButton(type: .roundedRect)
        button.setTitle("Test Crash", for: [])
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(button)
        button.frame = CGRect(x: 20, y: 50, width: 100, height: 30)
        button.addTarget(self, action: #selector(crashButtonTapped), for: .touchUpInside)
    }
    let testArr = [1]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // 회원가입: 아이디(100) > 닉네임(90) > 연락처(50) > 성별(10) > 가입 완료(5) > 5% 가입률
        // 이벤트 로그로 각 단계 확인 가능
        
        Analytics.logEvent("share_image", parameters: [
          "name": "JD" as NSObject,
          "full_text": "Test" as NSObject,
        ])
        
        Analytics.logEvent(AnalyticsEventSelectContent, parameters: [
          AnalyticsParameterItemID: "id-JDContent",
          AnalyticsParameterItemName: "TEST",
          AnalyticsParameterContentType: "cont",
        ])
        
        
    }
    @objc func crashButtonTapped() {
        let _ = testArr[1]
    }
}

