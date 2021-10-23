//
//  ExampleViewController.swift
//  SeSACEmotionDiary
//
//  Created by JD_MacMini on 2021/10/08.
//

import UIKit

enum GameJob {
    case rogue
    case warrior
    case mystic
    case shaman
    case fighter
}

class ExampleViewController: UIViewController {
    
    var selectJob: GameJob = .mystic
    let userNotificationCenter = UNUserNotificationCenter.current()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestNotificationAuthorization()
        
        switch selectJob {
        case .rogue:
            print("당신은 도적입니다")
        case .warrior:
            print("당신은 전사입니다")
        case .mystic:
            print("당신은 도사입니다")
        case .shaman:
            print("당신은 주술사입니다")
        case .fighter:
            print("당신은 격투가입니다")
        }

        
        //view.backgroundColor = setViewBackground()
        
        // 반환값이 있지만 사용 안하는 경우 경고가 나온다.
        // @discardableResult를 사용하면 반환값을 사용하지 않을 수 있다.
        setViewBackground()
    }
    
    @IBAction func showAlert(_ sender: UIButton) {
        
        // 1. UIAlertController : 밑바탕 + 타이틀 + 본문
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        
        
        
        // 2. UIAlertAction 생성: 버튼들
        let iPhone = UIAlertAction(title: "아이폰", style: .default)
        let iPhone2 = UIAlertAction(title: "아이폰2", style: .default)
        let iPad = UIAlertAction(title: "아이패드", style: .cancel)
        let watch = UIAlertAction(title: "와치", style: .destructive)
        
        // 3. 1+2
        alert.addAction(iPhone)
        alert.addAction(iPhone2)
        alert.addAction(iPad)
        alert.addAction(watch)
        
        // 컬러피커
        //let colorPicker = UIColorPickerViewController()
        
        // 4. Present
        present(alert, animated: true)
        //present(colorPicker, animated: true, completion: nil)
    }
    
    
    // 1. randomElement 반환값은 UIColor? 이므로 이 함수 반환값도 옵셔널로 해준다
    // 2. 강제해제는 !를 붙인다
    // 3. ??을 붙여 nil일때 반환될 값을 사용할 수 있다
    
    @discardableResult
    func setViewBackground() -> UIColor {
        let random: [UIColor] = [.red, .black, .gray, .green]
        print("discardable")
        return random.randomElement() ?? .yellow
    }
    
    // 권한요청
    func requestNotificationAuthorization() {
        let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .badge, .sound)
        
        userNotificationCenter.requestAuthorization(options: authOptions) { success, error in
            if success {
                self.sendNotification()
            }
        }
        
    }
    
    // 알림 보내기
    func sendNotification() {
        
        // 어떤 정보를 보낼지 컨텐츠 구성
        let notificationContent = UNMutableNotificationContent()
        
        notificationContent.title = "물 마실 시간이에요!"
        notificationContent.body = "하루 2리터 목표 달성을 위해 열심히 달려보아요"
        
        
        // 언제 보낼지 설정: 1. 간격, 2. 캘린더, 3. 위치
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 15, repeats: false)
        
        // 알림 요청
        let request = UNNotificationRequest(identifier: "\(Date())",
                                            content: notificationContent,
                                            trigger: trigger)
              
        // 알림센터에 요청 추가
        // 앱이 Foreground 상태라면 로컬 알림은 안오는게 default이다.
        
        userNotificationCenter.add(request) { error in
            if let error = error {
                print("Notification Error: ", error)
            }
        }
        
        // 포그라운드 로컬 알림 받기
        // 뱃지 제거 기능은 따로 구현
        // 알림을 하나 열었을때 관련 알림 모두 삭제
        // 알림 설정 취소시 알림 삭제 기능
        
    }
}
