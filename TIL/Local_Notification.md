# Local Notification

## User Notification Framework
- 사용자 디바이스에 앱의 알림을 표시하는 기능이 담긴 프레임워크
- 앱의 재사용률에 기여
- 로컬 환경에서 생성할 수도 있고, 앱을 관리하는 서버에서 원격으로 알림을 생성할 수도 있다.

## Remote Notification
- 서버에서 사용자 기기에 알람을 전달하는 방법. Push Notification
- 애플의 알림 서버(APNS)를 통해 사용자 기기에 전달된다.

## Local Notification
- 앱 내부에서 사용자 기기에 알림을 전달하는 방법
- 대체적으로 같은 시각에 비슷한 컨텐츠로 구성되어 있다.

## Local Notification 구현하기
#### **권한 요청**
1.  재료
- UNUserNotificationCenter.current()
- UNAuthorizationOptions(arrayLiteral:)
- UNMutableNotificationContent()
- UN...NotificationTrigger
- UNNotificationRequest

2. **예시 코드**

```swift
func setNotification(isSwitchOn: Bool) {

    // 1. NotificationCenter, UNAuthorizationOptions 생성
    let userNotificationCenter = UNUserNotificationCenter.current()
    let authOptions = UNAuthorizationOptions(arrayLiteral: .alert, .sound, .badge)
    
    // 2. requestAuthorization
    userNotificationCenter.requestAuthorization(options: authOptions) { isNotificationUsed, error in
                     
        // 3. 알림 사용 허락시 코드 작성
        if isNotificationUsed {

            // 4. 알림 내용 작성
            let notificationContent = UNMutableNotificationContent()        
            notificationContent.title = "알림 타이틀"
            notificationContent.body = "알림 내용"

            // 5. trigger, request 작성
            let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: true)
            let request = UNNotificationRequest(identifier: "\(Date())",
                                                content: notificationContent,
                                                trigger: trigger)

            // 6. 알림 센터에 request 등록
            userNotificationCenter.add(request!) { error in
                if let error = error {
                    print("Notification Error: ", error)
                }
            }
        }        
    }
}

```
