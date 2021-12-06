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

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
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
}

