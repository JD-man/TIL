//
//  AppDelegate.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/13.
//

import UIKit
import Firebase
import FirebaseMessaging

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        // Firebase 초기화
        FirebaseApp.configure()
        
        // 일람 권한
        if #available(iOS 10.0, *) {
          // For iOS 10 display notification (sent via APNS)
          UNUserNotificationCenter.current().delegate = self

          let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
          UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: { _, _ in }
          )
        } else {
          let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
          application.registerUserNotificationSettings(settings)
        }

        application.registerForRemoteNotifications()
        
        // 메세지 대리자 설정
        Messaging.messaging().delegate = self
        
        // 현재 등록 토큰 가져오기
        Messaging.messaging().token { token, error in
          if let error = error {
            print("Error fetching FCM registration token: \(error)")
          } else if let token = token {
            print("FCM registration token: \(token)")
          }
        }

        print(#function)        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        print(#function)
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
        print(#function)
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    
    // 포그라운드 수신 (로컬도 가능)
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        
        // foreground 특정뷰에서 푸시를 보고싶지 않을때
        if rootViewController is DetailViewController {
            completionHandler([])
        }
        else {
            completionHandler([.list, .banner, .badge, .sound])
        }
    }
    
    // 알림 클릭시 (로컬도 가능)
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        print("사용자가 알림 클릭함")
        
        // userInfo: keys - 1(광고), 2(채팅방), 3(사용자 설정)....
        print(response.notification.request.content.userInfo)
        print(response.notification.request.content.body)
        
        let userInfo = response.notification.request.content.userInfo
        if let value = userInfo[AnyHashable("key")] as? String, value == "1" {
            print("1번 푸시")
        }
        else {
            print("다른 푸시 입니다")
        }
        
        // SceneDelegate의 Window 객체 가져오기
        // 이 프로젝트 같이 탭바컨트롤러인 경우 구현이 난감함
        guard let rootViewController = (UIApplication.shared.connectedScenes.first?.delegate as? SceneDelegate)?.window?.rootViewController?.topViewController else { return }
        print(rootViewController)
        
//        if rootViewController is SnapDetailViewController {
//            rootViewController.present(DetailViewController(), animated: true, completion: nil)
//        }
        
        if rootViewController is DetailViewController {
//            let nav = UINavigationController(rootViewController: SnapDetailViewController())
//            rootViewController.navigationController?.present(nav, animated: true, completion: nil)
            
            rootViewController.navigationController?.pushViewController(SnapDetailViewController(), animated: true)
        }
        
        completionHandler()
    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }

}

extension UIViewController {
    
    var topViewController: UIViewController {
        return self.topViewController(currentViewController: self)
    }
    
    // window.rootViewContoller가 어떤건지에 따른 topViewController 가져오기
    // currentViewController: TabBar Controller
    func topViewController(currentViewController: UIViewController) -> UIViewController {
        if let tabBarController = currentViewController as? UITabBarController,
           let selectedViewController = tabBarController.selectedViewController {
            return self.topViewController(currentViewController: selectedViewController)
        }
        else if let navigationController = currentViewController as? UINavigationController,
                let visibleViewController = navigationController.visibleViewController {
            return self.topViewController(currentViewController: visibleViewController)
        }
        else if let presentedViewController = currentViewController.presentedViewController {
            return self.topViewController(currentViewController: presentedViewController)
        }
        else {
            return currentViewController
        }
    }
}
