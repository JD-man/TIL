//
//  ContentLocalizableString.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import Foundation

enum ContentLocalizableString: String {
    case navigation_title
    case titleTextField_placeholder
    case contentTextView_placeholder
    case saveButton_title
    
    var localized: String {
        return NSLocalizedString(self.rawValue,
                                 tableName: "ContentLocalization",
                                 bundle: .main,
                                 value: "",
                                 comment: "")
    }
}
