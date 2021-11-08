//
//  ViewController.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import UIKit

class MainTabBarController: UITabBarController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Check Custom Font name
        //FontFinder.findFont()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewConfig()
    }
    
    func viewConfig() {
        
        guard let items = tabBar.items else {
            return
        }
        items[0].title = HomeLocalizableString.navigation_title.localized
        items[1].title = SearchLocalizableString.navigation_title.localized
        items[2].title = CalendarLocalizableString.navigation_title.localized
        items[3].title = SettingLocalizableString.navigation_title.localized
    }
    
    
}

