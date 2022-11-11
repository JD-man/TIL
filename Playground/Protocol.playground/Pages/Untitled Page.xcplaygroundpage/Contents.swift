import UIKit

protocol Introduce {
    var name: String { get set }
    var age: Int { get }
    
    func introduce()
}

class Human {
    
}

class Jack: Human, Introduce {
    var name: String = "Jack"
    
    var age: Int = 10
    
    func introduce() {
        print("자기소개하기")
    }
}


// Protocol: 클래스, 구조체 청사진...
// 실질적인 구현은 하지 않는다. 명세만 담당!
// 특정 뷰객체

// 프로토콜 메서드
protocol OrderSystem {
    func recommandEventMenu()
    func askStampCard(count: Int) -> String
}

class StarBucksMenu {
    
}

class Smoothie: StarBucksMenu, OrderSystem {
    func recommandEventMenu() {
        print("스무디 이벤트 안내")
    }
    
    func askStampCard(count: Int) -> String {
        return "\(count)잔 적립 완료"
    }
}

class Coffee: StarBucksMenu, OrderSystem {
    let smoothie = Smoothie()
    
    func test() {
        smoothie is Coffee
        smoothie is StarBucksMenu
        smoothie is OrderSystem // 상속 받은 프로토콜로 형변환 가능. 이 성질은 Delegate에 사용됨
    }
    
    func recommandEventMenu() {
        print("커피 베이컨 이벤트 안내")
    }
    
    func askStampCard(count: Int) -> String {
        return "\(count * 2)잔 적립 완료"
    }
}


// 프로토콜 프로퍼티
// 프로토콜 전부 구현할 필요가없으면 @obcj optional 사용
// 프로토콜을 클래스에서만 사용하고 싶은 경우
@objc
protocol NavigationUIProtocol: AnyObject {
    @objc optional var titleString: String { get set }
    var mainTintColor: UIColor { get } // get만 사용한 경우, get 필수, set 선택
    
    init() // 초기화 구문: 구조체의 경우 멤버와이즈 구문이 있더라도 구현해줘야함
                    //  클래스의 경우, 부모 클래스에 추기화 구문과 프로토콜 초기화 구문이 구별, 명시
    
}

class JackViewController: UIViewController, NavigationUIProtocol {
    var titleString: String = "나의 일기"
    
    var mainTintColor: UIColor = .black
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = titleString
        view.backgroundColor = mainTintColor
    }
    
    
}

class Jack2ViewController: UIViewController, NavigationUIProtocol {
    var titleString: String {
        get {
            return "나의 일기"
        }
        set {
            title = newValue
        }
    }
    var mainTintColor: UIColor {
        return .black
    }
    
    override func viewDidLoad() {
        titleString = "새로운 일기"
    }
}

// 연산프로퍼티
struct SeSACStudent {
    var totalCount = 50
    var currentStudent = 0
    var studentUpdate: String {
        get {
            return "정원 마감까지 \(totalCount - currentStudent)명 남았습니다."
        }
        set {
            currentStudent += Int(newValue) ?? 0
        }
    }
}

var sesac = SeSACStudent()
sesac.studentUpdate = "10"
print(sesac.studentUpdate)
