//
//  TabBarController.swift
//  SeSAC_Week12
//
//  Created by JD_MacMini on 2021/12/15.
//

import UIKit

// Navigation Controller, Tabbar Controller 둘이 비슷함
// TabBar, TabBarItem(title, image, selectImage), tintColor
// iOS13: UITabBarAppearence ->
class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBarController?.tabBar.barTintColor = .systemBackground
        
        let firstVC = SettingViewController(nibName: "SettingViewController", bundle: nil)
        firstVC.tabBarItem.title = "설정"
        firstVC.tabBarItem.image = UIImage(systemName: "gearshape")
        firstVC.tabBarItem.selectedImage = UIImage(systemName: "gearshape.fill")
        
        let secondVC = SnapDetailViewController()
        secondVC.tabBarItem = UITabBarItem(title: "스냅",
                                           image: UIImage(systemName: "bolt.horizontal"),
                                           selectedImage: UIImage(systemName: "bolt.horizontal.fill"))
        
        
        let thirdVC = DetailViewController()
        thirdVC.tabBarItem = UITabBarItem(title: "정보",
                                           image: UIImage(systemName: "fanblades"),
                                           selectedImage: UIImage(systemName: "fanblades.fill"))
        let navThirdVC = UINavigationController(rootViewController: thirdVC)
        
        setViewControllers([firstVC, UINavigationController(rootViewController: secondVC), navThirdVC], animated: true)
        
        let appearence = UITabBarAppearance()
        appearence.configureWithDefaultBackground()
        
        tabBar.standardAppearance = appearence
        tabBar.scrollEdgeAppearance = appearence
        tabBar.tintColor = .label
    }
}

extension TabBarController: UITabBarControllerDelegate {
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
    }
}
