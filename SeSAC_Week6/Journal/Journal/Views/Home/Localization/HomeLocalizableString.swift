//
//  HomeViewLocalizableString.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/01.
//

import Foundation

enum HomeLocalizableString: String {
    case navigation_title
    
    var localized: String {
        return NSLocalizedString(self.rawValue,
                                 tableName: "HomeLocalization",
                                 bundle: .main,
                                 value: "",
                                 comment: "")
    }
}
