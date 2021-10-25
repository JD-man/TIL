import UIKit



// 1급 객체
//// 1. 변수나 상수에 함수를 대입할 수 있다.
//
//func checkBankInformation(bank: String) -> Bool {
//    let bankArray = ["우리", "KB", "신한"]
//    return bankArray.contains(bank) ? true : false
//}
//
//// 함수 실행결과 Bool값을 반환받음. 함수가 check 상수에 들어간것이 아님
//let check = checkBankInformation(bank: "우리")
//
//// 함수 자체를 checker 상수에 넣음. 타입은 (String) -> Bool
//let checker = checkBankInformation
//// 함수를 호출해야 함수가 실행된다.
//checker("우리")
//
//
//// (String) -> Bool은 함수의 타입
//
//let tupleExample = (1, true, "우왕굳", 3.3)
//tupleExample.1
//
//
//// Function Type 1. (String) -> String
//func hello(nickname: String) -> String {
//    return "저는 \(nickname)입니다."
//}
//
//
//func hello(userName: String) -> String {
//    return "저는 \(userName)입니다."
//}
//
//// Function Type 2. (String, Int) -> String
//func hello(nickname: String, userAge: Int) -> String {
//    return "저는 \(nickname), \(userAge)입니다."
//}
//
//// Function Type 3. () -> Void, () -> ()
//// typealias Void = ()
//func hello() {
//    print("안녕하세요 반갑습니다")
//}
//
//// 함수가 오버로딩됐을때, 타입 어노테이션을 통해 구별 가능. 함수의 식별자로 구분 가능
//let a: (String) -> String = hello(nickname:)
//let b: (String, Int) -> String = hello(nickname: userAge:)
//let c: (String, Int) -> String = hello(nickname: userAge:)
//
//// b상수를 hello 함수처럼 사용가능
//b("우왕굳", 9)


// 2. 함수의 반환 타입으로 함수를 사용할 수 있다. 구조체 클래스 등 반환값으로 사용할 수 있음

// () -> String
func currentAccount() -> String {
    return "계좌 있음"
}
// () -> String
func noCurrentAccount() -> String {
    return "계좌 없음"
}
// 가장 왼쪽에 위치한 -> 를 기준으로 오른쪽에 놓인 모든 타입은 반환값을 의미한다.
func checkBankInformation(bank: String) -> ( () -> String ) {
    let bankArray = ["우리", "KB", "신한"]
    return bankArray.contains(bank) ? currentAccount : noCurrentAccount
}

let minsu = checkBankInformation(bank: "농협")
minsu()


// 2-1. Calculate
func add(a: Int, b: Int) -> Int {
    return a + b
}

func sub(a: Int, b: Int) -> Int {
    return a - b
}

func mul(a: Int, b: Int) -> Int {
    return a * b
}

func div(a: Int, b: Int) -> Int {
    return a / b
}

func calculate(operand: String) -> (Int, Int) -> Int {
    switch operand {
    case "+":
        return add
    case "-":
        return sub
    case "*":
        return mul
    case "/":
        return div
    default:
        return add
    }
}

calculate(operand: "+")(1,1)
calculate(operand: "-")(1,1)


// 3. 함수의 인자값으로 함수를 사용할 수 있다. - 콜백 함수로 자주 사용이 됨. 콜백 함수 : 특정 구문의 실행이 끝나면 시스템이 호출하도록 처리된 함수


// () -> ()
func oddNumber() {
    print("짝수")
}

func evenNumber() {
    print("홀수")
}

func resultNumber(base: Int, odd: () -> (), even: () -> ()) {
    return base.isMultiple(of: 2) ? odd() : even()
}

resultNumber(base: 5, odd: oddNumber, even: evenNumber)

func plusNumber() {
    print("더하기")
}

func minusNumber() {
    print("빼기")
}

// 함수의 타입이 같기 때문에 의도하지 않은 상황이 나올 수 있음.
// 실질적인 연산은 인자값으로 받는 함수에 달려있어서, 중개 역할만 담당한다고 하여 브로커 함수라고 한다.
resultNumber(base: 5, odd: plusNumber, even: evenNumber)
resultNumber(base: 9) {
    print("odd") // 클로저 사용됨
} even: {
    print("even")
}

// 클로저의 유래

// 외부 함수
func drawingGame(item: Int) -> String {
    func luckyNumber(number: Int) -> String {
        return "\(number * Int.random(in: 1 ... 10))"
    }
    
    return luckyNumber(number: item * 2)
}

drawingGame(item: 1) // 외부 함수의 생명 주기 -> 내부 함수의 생명 주기 (은닉성)

func drawingGame2(item: Int) -> (Int) -> String {
    func luckyNumber(number: Int) -> String {
        return "\(item * number * Int.random(in: 1 ... 10))"
    }
    
    return luckyNumber
}

let luckyNumber = drawingGame2(item: 10) // 외부함수는 생명주기가 끝남. 내부함수는 반환을 했기 때문에 계속 사용 가능.
luckyNumber(2)

/*
 은닉성이 있는 내부 함수를 외부 함수의 실행 결과로 반환하면서 내부 함수를 외부에서도 접근 가능하게 되었음.
 이건 생명 주기에도 영향을 미침.
 외부 함수가 종료되더라도 내부 함수는 살아있음.
 */


// 클로저 캡쳐 때문에 외부함수의 생명주기가 끝나도 item을 사용할 수 있음

// 클로저란
/*
 같은 정의를 갖는 함수가 서로 다른 환경을 저장하는 결과가 생기게 됨.
 클로저에 의해 내부 함수 주변의 지역 변수나 상수도 함께 저장됨. -> 값이 캡쳐되었다 라고 표현한다.
 주변 환경에 포함된 변수나 상수의 타입이 기본 자료형이나 구조체 자료형일 때 발생함.
 클로저 캡쳐의 기본 기능이다.
 */

// 스위프트는 특히 이름이 없는 함수로 클로저를 사용하고 있고, 내부 함수 주변의 변수나 상수로부터 값을 캡쳐할 수 있는 "경량 문법"으로 많이 사용하고 있다.


// () -> ()
func studyiOS() {
    print("iOS 개발자를 위해 열공중")
}

let studyiOSHarder = {
    print("iOS 개발자를 위해 열공중")
}

let studyiOSHarder2 = { () -> () in
    print("iOS 개발자를 위해 열공중")
}

studyiOSHarder2()

func getStudyWithMe(study: () -> () ) {
    study()
}

// 인라인 클로저
getStudyWithMe(study: { () -> () in
    print("iOS 개발자를 위해 열공중")
})

getStudyWithMe(study: studyiOSHarder2)

// 트레일링 클로저
getStudyWithMe() { () -> () in
    print("iOS 개발자를 위해 열공중")
}


func todayNumber(result: (Int) -> String) {
    result(Int.random(in: 1 ... 100))
}

todayNumber { value in
    print("하하하")
    return "\(value)"
}

todayNumber(result: { (randomNumber: Int) -> String in
    return "행운의 숫자 \(randomNumber)"
})

todayNumber(result: { randomNumber in
    return "행운의 숫자 \(randomNumber)"
})

todayNumber(result: {
    return "행운의 숫자 \($0)"
})

todayNumber(result: {
    "행운의 숫자 \($0)"
})

todayNumber {
    "행운의 숫자 \($0)"
}

// @autoclosure, @escaping
