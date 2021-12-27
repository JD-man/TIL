//
//  User.swift
//  SeSAC_Week14
//
//  Created by JD_MacMini on 2021/12/27.
//

import Foundation

// MARK: - Welcome
struct User: Codable {
    let jwt: String
    let user: UserClass
}

// MARK: - User
struct UserClass: Codable {
    let id: Int
    let username, email: String
}
 
