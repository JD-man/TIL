//
//  CalenderLocalizableString.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import Foundation

enum CalendarLocalizableString: String {
    case navigation_title
    
    var localized: String {
        return NSLocalizedString(self.rawValue,
                                 tableName: "CalendarLocalization",
                                 bundle: .main,
                                 value: "",
                                 comment: "")
    }
}
