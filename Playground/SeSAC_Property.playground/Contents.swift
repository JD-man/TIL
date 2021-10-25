import UIKit

//enum DrinkSize {
//    case short, tall, grande, venti
//}
//
//struct DrinkStruct {
//    let name: String
//    var count: Int
//    var size: DrinkSize
//}
//
//class DrinkClass {
//    let name: String
//    var count: Int
//    var size: DrinkSize
//    
//    init(name: String, count: Int, size: DrinkSize) {
//        self.name = name
//        self.count = count
//        self.size = size
//    }
//}
//
//
//let drinkStruct = DrinkStruct(name: "아메리카노", count: 3, size: .tall)
////drinkStruct.count = 2
////drinkStruct.size = .venti
//
//let drinkClass = DrinkClass(name: "블루베리 스무디", count: 2, size: .venti)
//drinkClass.count = 5
//drinkClass.size = .tall
//
//print(drinkClass.name, drinkClass.count, drinkClass.size)
//
//
//// 지연 저장 프로퍼티
//
//struct Poster {
//    var image: UIImage = UIImage(systemName: "star") ?? UIImage()
//    
//    init() {
//        print("1000 Poster Initialized")
//    }
//}
//
//struct MediaInformation {
//    var mediaTitle: String
//    var mediaRuntime: Int
//    lazy var mediaPoster: Poster = Poster()
//}
//
//var media = MediaInformation(mediaTitle: "오징어게임", mediaRuntime: 333)
//print("1")
//media.mediaPoster
//print("2")
//
//// 연산 프로퍼티 & 프로퍼티 감시자
//// 타입알리어스
//class BMI {
//    typealias BMIValue = Double
//    
//    // 연산프로퍼티에서는 사용 X (get/set과 사용 X)
//    var userName: String {
//        willSet {
//            print("닉네임 변경 예정: \(userName) -> \(newValue)")
//        }
//        
//        didSet {
//            changeNameCount += 1
//            print("닉네임 바뀜")
//            print("닉네임 변경 결과: \(oldValue) -> \(userName)")
//        }
//    }
//    
//    var changeNameCount = 0
//    
//    var userWeight: BMIValue
//    var userHeight: BMIValue
//    
//    var BMIResult: String {
//        get {
//            let bmiValue = ( userHeight * userWeight ) / userHeight
//            let bmiStatus = bmiValue < 18.5 ? "저체중" : "정상"
//            return "\(userName)님의 BMI 지수는 \(bmiValue)로, \(bmiStatus)입니다."
//        }
//        set {
//            userName = newValue
//        }
//    }
//    
//    init(userName: String, userWeight: BMIValue, userHeight: BMIValue) {
//        self.userName = userName
//        self.userWeight = userWeight
//        self.userHeight = userHeight
//    }
//}
//
//
//let bmi = BMI(userName: "JACK", userWeight: 50, userHeight: 160)
//print(bmi.BMIResult)
//bmi.BMIResult = "abc"
//bmi.BMIResult = "cd"
//bmi.BMIResult = "addf"
//print(bmi.BMIResult)
//print(bmi.changeNameCount)


// 타입 프로퍼티

//class User {
//
//    // 타입 저장프로퍼티
//    static let nickname = "고래밥2"
//
//    // 타입 프로퍼티 옵저버
//    static var totalOrderCount: Int = 0 {
//        didSet {
//            print("총 주문횟수: \(oldValue) -> \(totalOrderCount)로 증가")
//        }
//
//    }
//
//    // 타입 연산프로퍼티
//
//    static var orderProduct: Int {
//        get {
//            return totalOrderCount
//        }
//        set {
//            totalOrderCount += newValue
//        }
//    }
//}
//
//
//User.nickname
//User.totalOrderCount
//User.orderProduct
//
//User.orderProduct = 10
//print(User.totalOrderCount)
//User.orderProduct = 20
//print(User.totalOrderCount)


// 인스턴스 메서드 : 구조체에서 자신의 프로퍼티값을 인스턴스 메서드 내에서 변경하게 될 경우 mutating 사용 필요
//struct Point {
//    var x = 0.0
//    var y = 0.0
//
//    // 인스턴스 메서드
//    mutating func moveBy(x: Double, y: Double) {
//        self.x += x
//        self.y += y
//    }
//}
//
//var somePoint = Point()
//print("POINT: \(somePoint.x), \(somePoint.y)")
//somePoint.moveBy(x: 3.0, y: 5.0)
//print("POINT: \(somePoint.x), \(somePoint.y)")


class Coffee {
    static var name = "아메리카노"
    static var shot = 2
    
    // 타입 메서드
    static func plusShot() {
        shot += 1
    }
    
    // 타입 메서드
    class func minusShot() {
        shot -= 1
    }
    
    func hello() {
        print("hello coffee")
    }
}


Coffee.plusShot()

class Latte: Coffee {
    
    
    // 인스턴스 메서드는 재정의 가능
    override func hello() {
        print("hello Latte")
    }
    
    // 타입 메서드 중 class func는 재정의 가능
    override class func minusShot() {
        print("타입 메서드를 상속받아 재정의")
    }
    
}

Coffee.minusShot()
Latte.minusShot()



// 싱글턴 패턴
class UserDefaultHelper {
    static let shared = UserDefaultHelper()
    
    let userDefaults = UserDefaults.standard
    
    enum Key: String {
        case nickname, age, rate
    }
    
    var userNickname: String? {
        
        get {
            return userDefaults.string(forKey: Key.nickname.rawValue)
        }
        
        set {
            userDefaults.set(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var userAge: Int? {
        get {
            return userDefaults.integer(forKey: Key.age.rawValue)
        }
        set {
            userDefaults.set(newValue, forKey: Key.age.rawValue)
        }
    }
    
    
    // 용도에 맞게 사용하게 막기.
    private init() {
        
    }
        
}
print(UserDefaultHelper.shared.userNickname)
print(UserDefaultHelper.shared.userAge)

UserDefaultHelper.shared.userNickname = "고래밥"
UserDefaultHelper.shared.userAge = 15

print(UserDefaultHelper.shared.userNickname)
print(UserDefaultHelper.shared.userAge)

// 이거를 또 반복작성하는걸 막아주는게 Property Wrapper



