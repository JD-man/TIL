//
//  LocalizationStrings.swift.swift
//  SeSAC_Week6
//
//  Created by JD_MacMini on 2021/11/01.
//

import Foundation

enum LocalizableStrings: String {
    case welcome_text
    case data_backup
    case data_restore
    
    var localized: String {
        return self.rawValue.localized()
    }
    var localizedWithSetting: String {
        return self.rawValue.localized(tableName: "Setting")
    }
}
