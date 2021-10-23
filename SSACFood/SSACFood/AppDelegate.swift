//
//  AppDelegate.swift
//  SSACFood
//
//  Created by JD_MacMini on 2021/09/29.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    // 13.0 이전에는 원래 윈도우가 여기에 있었음
    // 윈도우를 여기에서 구현해야함
    // 윈도우는 뷰컨트롤러를 교체시키면서 아이폰 화면에 보여주는 역할을 한다.
    //var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    // MARK: UISceneSession Lifecycle
    // 이 밑은 iOS 13.0 이상에서만 있는 기능
    // available annotation 필요
    
    @available (iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    @available (iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

