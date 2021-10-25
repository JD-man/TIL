import UIKit

// 옵셔널 바인딩 : if let, guard let

enum UserMissionStatus: String {
    case missionFailed = "실패"
    case missionSuceed = "성공"
}

func checkNumber(number: Int?) -> (UserMissionStatus, Int?) {
    if number != nil {
        return (.missionSuceed, number!)
    } else {
        return (.missionFailed, nil)
    }
}

func checkNumber2(number: Int?) -> (UserMissionStatus, Int?) {
    if let value = number {
        return (.missionSuceed, value)
    } else {
        return (.missionFailed, nil)
    }
}

func checkNumber3(number: Int?) -> (UserMissionStatus, Int?) {
    guard let value = number else {
        return (.missionFailed, nil)
    }
    return (.missionSuceed, value)
}


// 타입 캐스팅: 메모리의 인스턴스 타입은 바뀌지 않는다.
let array: [Any] = [1, true, "안녕"]

let arrayInt = array as? [Int]

class Mobile {
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

class AppleMobile: Mobile {
    var company = "애플"
}

class GoogleMobile: Mobile {
    
}

let mobile = Mobile(name: "PHONE")
let apple = AppleMobile(name: "iPhone")
let google = GoogleMobile(name: "Galaxy")

print(mobile is Mobile)
print(apple is Mobile)
print(google is Mobile)

print(mobile is AppleMobile)

let iPhone: Mobile = AppleMobile(name: "iPad")
iPhone.name
(iPhone as? AppleMobile)?.company

if let value = iPhone as? AppleMobile {
    print("타입캐스팅 + 옵셔널바인딩 성공", value.company)
}
