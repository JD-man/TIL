//
//  Cast.swift
//  SeSACWeek13
//
//  Created by JD_MacMini on 2021/12/21.
//

import Foundation


struct Cast: Codable {
    let peopleListResult: PeopleListResult
}

// MARK: - PeopleListResult
struct PeopleListResult: Codable {
    let totCnt: Int
    let peopleList: [PeopleList]
    let source: String
}

// MARK: - PeopleList
struct PeopleList: Codable {
    let peopleCd: String
    let peopleNm: String
    let peopleNmEn: String
    let repRoleNm: String    
    let filmoNames: String
}
