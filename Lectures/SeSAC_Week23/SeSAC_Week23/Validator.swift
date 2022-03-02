//
//  Validator.swift
//  SeSAC_Week23
//
//  Created by JD_MacMini on 2022/03/02.
//

import Foundation

final class Validator {
    func isValidID(id: String) -> Bool {
        return id.contains("@") && id.count >= 6
    }
    
    func isValidPassword(password: String) -> Bool {
        return password.count >= 6 && password.count < 10
    }
    
    func isEqualPassword(password: String, check: String) -> Bool {
        return password == check
    }
}
