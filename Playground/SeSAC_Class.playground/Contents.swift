import UIKit

/*

첫번째 몬스터
var easyMonsterClother: String = "Orange"
var easyMonsterSpeed: Int = 1
var easyMonsterPower: Int = 10
var easyMonsterExp: Double = 50.0

두번째 몬스터
var easyMonster2Clother: String = "Orange"
var easyMonster2Speed: Int = 1
var easyMonster2Power: Int = 10
var easyMonster2Exp: Double = 50.0

=> 몬스터 만들때마다 이러기 힘들다.
=> 클래스를 만든다.
 
*/


// 클래스의 모든 프로퍼티는 초기화 되어 있어야 한다.
// 프로퍼티가 옵셔널일 경우, 런타임 오류가 발생할 수 있다. nil이 들어가는 프로퍼티가 아니면 안쓰는게 낫다.
// 초기화는 초기화 구문을 통해 한다. init
class Monster {
    
    var clothes: String
    var speed: Int
    var power: Int
    var expPoint: Double
    
    init(clothes: String, speed: Int, power: Int, expPoint: Double) {
        self.clothes = clothes
        self.speed = speed
        self.power = power
        self.expPoint = expPoint
    }
    
    func attack() {
        print("몬스터 공격!!")
    }
}

// Monster 클래스의 인스턴스
var easyMonster = Monster(clothes: "Orange", speed: 1, power: 1, expPoint: 50.0)
easyMonster.clothes
easyMonster.speed
easyMonster.power
easyMonster.expPoint

var hardMonster = Monster(clothes: "Blue", speed: 5, power: 5, expPoint: 100.0)
hardMonster.clothes
hardMonster.speed
hardMonster.power
hardMonster.expPoint

// 클래스는 상속이 가능하다.
// Monster = SuperClass, BossMonster: SubClass
class BossMonster: Monster {
    var bossName: String
    
    init(bossName: String, clothes: String, speed: Int, power: Int, expPoint: Double) {
        self.bossName = bossName
        super.init(clothes: clothes, speed: speed, power: power, expPoint: expPoint)
    }
    
    override func attack() {
        print("보스만의 강력한 공격!!")
    }
}

var boss = BossMonster(bossName: "끝판왕보스", clothes: "Red", speed: 50, power: 50, expPoint: 3000.0)
boss.bossName
boss.clothes
boss.power
boss.attack()
//boss.bossUniqueAttack()


/*

// 구조체는 초기화 구문을 제공해준다. -> 멤버와이즈 초기화 구문
// 멤버 : Property, Method
struct Monster {
    
    var clothes: String
    var speed: Int
    var power: Int
    var exp: Double
}

var easyMonster = Monster(clothes: "Orange", speed: 1, power: 1, exp: 50.0)
easyMonster.clothes
easyMonster.speed
easyMonster.power
easyMonster.exp

var hardMonster = Monster(clothes: "Blue", speed: 5, power: 5, exp: 100.0)
hardMonster.clothes
hardMonster.speed
hardMonster.power
hardMonster.exp

 */

// Value Type vs Reference Type

// String은 구조체. 구조체는 Value Type
// Value Type은 값을 복사해서 메모리에 올라간다.
var nickname: String = "고래밥"
var subNickname = nickname

nickname = "칙촉"

print(nickname) // 칙촉
print(subNickname) // 고래밥
// 얘는 nickname의 고래밥이 subNickname 메모리영역으로 복사돼서 들어갔고
// 메모리 영역이 다르기 때문에 nickname 메모리영역의 값이 바뀌어도 그대로임.


// SuperBoss는 클래스. 클래스는 Reference Type
// 클래스는 값이 저장되는 부분이 따로있다.
class SuperBoss {
    var name: String
    var level: Int
    var power: Int
    
    init(name: String, level: Int, power: Int) {
        self.name = name
        self.level = level
        self.power = power
    }
}

// hardStepBoss 메모리영역이 따로 있지만 클래스의 저장주소를 가지고 있다.
var hardStepBoss = SuperBoss(name: "쉬운보스", level: 1, power: 10)
// easyStepBoss는 hardStepBoss의 메모리 주소값을 가져온다.
var easyStepBoss = hardStepBoss


// hardStepBoss의 영역 -> 클래스가 저장되어있는 영역 -> 여기에서 power, level 등 변경
hardStepBoss.power = 50000
hardStepBoss.level = 100
hardStepBoss.name = "어려운 보스"

print(hardStepBoss.name, hardStepBoss.level, hardStepBoss.power)
print(easyStepBoss.name, easyStepBoss.level, easyStepBoss.power)

// 함수 반환값

func sayHello() -> String {
    
    print("안녕하세요")
    return "안녕하세요! 반갑습니다!"
    
}

print("자기소개 : \(sayHello())")

func bmi() -> Double {
    // 조건문
    
    return 20.1
}

func bmiResult() -> [String] {
    let name = "고래밥"
    let result = "정상"
    return [name,result]
}


let value = bmiResult()
print(value[0] + "님의 BMI 지수는 " + value[1] + "입니다")

// 튜플

let userInfo = ("고래밥", "email@email.com", true, 4.5)

print(userInfo.0)
print(userInfo.1)

// @discardableResult: 함수의 반환값을 무시

// 열거형
enum AppleDevice {
    case iPhone
    case iPad
    case watch
}

enum GameJob: String {
    case rogue = "도적"
    case warrior = "전사"
    case mystic = "도사"
    case shaman = "주술사"
    case fighter = "격투가"
}

let selectJob: GameJob = .mystic

print("당신은 \(selectJob.rawValue)입니다.")

//if selectJob == .mystic {
//    print("당신은 도사입니다.")
//} else if selectJob == .shaman {
//    print("당신은 주술사입니다.")
//}

enum Gender {
    case man, woman
}

switch selectJob {
case .shaman:
    print("당신은 도사입니다.")
case .mystic:
    print("당신은 주술사입니다.")
default:
    print("당신은 평민입니다.")
}

enum HTTPCode: Int {
    case OK = 200
    case SERVER_ERROR = 500
    case NO_PAGE
    
    func showStatus() -> String {
        switch self {
        case .OK:
            return "정상입니다."
        case .SERVER_ERROR:
            return "서버 점검중입니다."
        case .NO_PAGE:
            return "잘못된 주소입니다."
        }
    }
}

var status: HTTPCode = .OK

print(status.rawValue)
print(HTTPCode.NO_PAGE.rawValue)

//if status == .NO_PAGE {
//    print("잘못된 주소입니다.")
//} else if status == .SERVER_ERROR {
//    print("서버에 문제가 생겼습니다.")
//}


print(status.showStatus())
