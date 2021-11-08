import UIKit

class User {
    var name: String = ""
    var age: Int = 0
}

struct UserStruct {
    var name: String = ""
    var age: Int = 0
}

// 만들고 싶은 init을 extension으로 빼면 Memberwisw, Default Initializer 모두 사용가능.
extension UserStruct {
    init(age: Int) {
        self.name = "손님"
        self.age = age
    }
}

let a = User() // 초기화 구문, 초기화 메서드 -> Default Initializer
let b = UserStruct(name: "bb", age: 9) // Memberwise Initializer
let c = UserStruct()

// .init을 생략하면서 사용하고 있는것
let color = UIColor(red: 0.5, green: 0.5, blue: 1.0, alpha: 1)
let color2 = UIColor.init(red: 0.5, green: 0.5, blue: 1.0, alpha: 1)


// 편의 생성자. convenience initializer

class Coffee {
    let shot: Int
    let size: String
    let menu: String
    let mind: String
    
    // Designated initializer
    init(shot: Int, size: String, menu: String, mind: String) {
        self.shot = shot
        self.size = size
        self.menu = menu
        self.mind = mind
    }
    
    // Convenience initializer
    // 기본(2 tall)
    convenience init(value: String) {
        self.init(shot: 2, size: "tall", menu: value, mind: "..")
    }
}

let coffee = Coffee(shot: 1, size: "크게", menu: "아아", mind: "많이")
let coffee2 = Coffee(value: "아아")

print(coffee2.shot, coffee2.size, coffee2.menu, coffee2.mind)

extension UIColor {
    convenience init(red: CGFloat, green: CGFloat, blue: CGFloat) {
        self.init(red: red/255, green: green/255, blue: blue/255, alpha: 1.0)
    }
}

let customColor = UIColor(red: 25, green: 12, blue: 156)


// 2: 프로토콜에도 초기화 구문 가능
// 3: 초기화구문 델리게이션
protocol myprotocol {
    
}
