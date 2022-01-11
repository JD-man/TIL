import UIKit

//// 사용자, 길드, 길드장
//
//class Guild {
//    var guildName: String
//
//    var owner: User?
//
//    init(guildName: String) {
//        self.guildName = guildName
//        print("Guild Init")
//    }
//
//    deinit {
//        print("Guild Deinit")
//    }
//}
//
//class User {
//    var nickname: String
//    var guild: Guild?
//
//    init(nickname: String) {
//        self.nickname = nickname
//        print("User Init")
//    }
//
//    deinit {
//        print("User Deinit")
//    }
//}
//
//var user: User? = User(nickname: "미묘한도사") // user RC 1
////user = nil
//
//var sesac: Guild? = Guild(guildName: "SeSAC") // sesac RC 1
////sesac = nil
//
//sesac?.owner = user // user RC 2
//user?.guild = sesac // sesac RC 2
//
//// 순환참조방지
//// 인스턴스를 nil하기 전에 어느 하나를 먼저 nil 해야함
//sesac?.owner = nil // user RC -1. user는 RC가 0이 됨. user가 해제되면서 sesac RC -1.
//
//user = nil // user RC -1
//sesac = nil // sesac RC -1
//
//// 지들끼리 참조해서 RC가 0이 아님.
//// -> 순환참조발생


//===================================================================================================

// weak: 참조할때 RC 1 증가시키지 않음

//class Guild {
//    var guildName: String
//
//    weak var owner: User? // RC를 증가시키지 않음. 약한참조
//
//    init(guildName: String) {
//        self.guildName = guildName
//        print("Guild Init")
//    }
//
//    deinit {
//        print("Guild Deinit")
//    }
//}
//
//class User {
//    var nickname: String
//    var guild: Guild?
//
//    init(nickname: String) {
//        self.nickname = nickname
//        print("User Init")
//    }
//
//    deinit {
//        print("User Deinit")
//    }
//}
//
//var user: User? = User(nickname: "미묘한도사") // user RC 1
////user = nil
//
//var sesac: Guild? = Guild(guildName: "SeSAC") // sesac RC 1
////sesac = nil
//
//sesac?.owner = user // user RC 1 (weak)
//user?.guild = sesac // sesac RC 2
//
//user = nil // user RC -1 -> user deinit -> sesac RC -1
//sesac = nil // sesac RC -1


// =======================================================================


class Guild {
    var guildName: String
    unowned var owner: User? // RC를 증가시키지 않음. 미소유참조

    init(guildName: String) {
        self.guildName = guildName
        print("Guild Init")
    }

    deinit {
        print("Guild Deinit")
    }
}

class User {
    var nickname: String
    var guild: Guild?

    init(nickname: String) {
        self.nickname = nickname
        print("User Init")
    }

    deinit {
        print("User Deinit")
    }
}

var user: User? = User(nickname: "미묘한도사") // user RC 1
//user = nil

var sesac: Guild? = Guild(guildName: "SeSAC") // sesac RC 1
//sesac = nil

sesac?.owner = user // user RC 1 (weak)
user?.guild = sesac // sesac RC 2

user = nil // user RC -1 -> user deinit -> sesac RC -1
//sesac = nil // sesac RC -1

print(sesac?.owner) // 미소유참조는 메모리 주소를 그대로 가지고 있음. 그런데 owner는 이미 해제됐고 접근해서 오류나옴
