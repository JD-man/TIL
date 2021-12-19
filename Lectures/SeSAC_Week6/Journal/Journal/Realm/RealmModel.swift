//
//  RealmModel.swift
//  Journal
//
//  Created by JD_MacMini on 2021/11/02.
//

import Foundation
import RealmSwift

// UserDiary: 테이블 이름
// @persisted : Column 이름
class UserJournal: Object {
    @Persisted var title: String // 제목(필수)
    @Persisted var content: String? // 내용(옵션)
    @Persisted var writeDate = Date() // 작성 날짜(필수)
    @Persisted var regDate = Date() // 등록일(필수)
    @Persisted var favorite: Bool // 즐겨찾기
    
    
    // PK(필수) : Int, String, UUID, ObjectID -> AutoIncrement
    @Persisted(primaryKey: true) var _id: ObjectId
    
    convenience init(title: String, content: String?, writeDate: Date, regDate: Date, favorite: Bool = false) {
        self.init()
        self.title = title
        self.content = content
        self.writeDate = writeDate
        self.regDate = regDate
        self.favorite = favorite
    }
}

