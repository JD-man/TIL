//
//  ViewController.swift
//  SeSAC_Week6
//
//  Created by JD_MacMini on 2021/11/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var backupLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /*
         ====> S-CoreDream-2ExtraLight
         ====> S-CoreDream-5Medium
         ====> S-CoreDream-9Black
         */
        
        // 폰트 이름 확인하기
//        for family in UIFont.familyNames {
//            print(family)
//
//            for sub in UIFont.fontNames(forFamilyName: family) {
//                print("====> \(sub)")
//            }
//        }
        
        // "welcome_text"
        //welcomeLabel.text = LocalizableStrings.welcome_text.localized
        welcomeLabel.text = LocalizableStrings.data_restore.localizedWithSetting
        backupLabel.text = LocalizableStrings.data_backup.localizedWithSetting
        
        
        welcomeLabel.font = UIFont.mainMedium
        backupLabel.font = UIFont.mainMedium
    }


}

