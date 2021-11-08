//
//  SettingLocalizableString.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import Foundation

enum SettingLocalizableString: String {
    case navigation_title
    
    var localized: String {
        return NSLocalizedString(self.rawValue,
                                 tableName: "SettingLocalization",
                                 bundle: .main,
                                 value: "",
                                 comment: "")
    }
}
