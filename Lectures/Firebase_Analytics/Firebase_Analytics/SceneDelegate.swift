//
//  SceneDelegate.swift
//  Firebase_Analytics
//
//  Created by JD_MacMini on 2021/12/06.
//

import UIKit
import FirebaseAnalytics
import AppTrackingTransparency

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
        
        // ATT Framework
        // iOS 15버전 이후 present 방식이 변경돼 SceneDelegate sceneDidBecomeActive에서 1초 뒤에 얼럿을 띄워줘야한다
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            ATTrackingManager.requestTrackingAuthorization { status in
                switch status {
                case .notDetermined:
                    print("notDetermined")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .restricted:
                    print("restricted")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .denied:
                    print("denied")
                    Analytics.setAnalyticsCollectionEnabled(false)
                case .authorized:
                    print("authorized") // 허용 했을 경우만 애널리틱스 수집 가능
                    Analytics.setAnalyticsCollectionEnabled(true)
                @unknown default:
                    print("unknown default")
                    Analytics.setAnalyticsCollectionEnabled(false)
                }
            }
        }
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

