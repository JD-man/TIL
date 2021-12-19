//
//  RealmQuery.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/05.
//

import Foundation
import UIKit
import RealmSwift

extension UIViewController {
    func searchQueryFromUserDiary(text: String) -> Results<UserJournal> {
        let localRealm = try! Realm()
        
        let search = localRealm.objects(UserJournal.self).filter("title CONTAINS[c] '\(text)' OR content CONTAINS[c] '\(text)'")
        return search
    }
    
    func getAllDiaryCountFromUserDiary() -> Int {
        let localRealm = try! Realm()
        
        return localRealm.objects(UserJournal.self).count
    }
}
