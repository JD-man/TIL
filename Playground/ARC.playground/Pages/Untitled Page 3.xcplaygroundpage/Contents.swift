import Foundation

func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()
incrementByTen()
incrementByTen()
incrementByTen()

// makeIncrementer의 주기가 끝났는데도 10씩 증가함!!
// runningTotal, amount를 내부적으로 저장하고 있음!!
// 내부적으로 저장하는걸 캡쳐라고함. -> 메모리 이슈가 생길 수 있음

func firstClosure() {
    var number = 0
    
    print("1: \(number)")
    
    // 내부적으로 저장(캡쳐)하고 있음.
    // number는 Int -> 구조체 -> 값복사 -> 하지만 참조가 되는 형태로 캡쳐가 된다.
    // 클로저는 캡쳐를 참조타입으로 한다!! -> Reference Capture
    
    let closure: () -> Void = { [number] in // 캡쳐리스트를 사용하면 값타입처럼 복사해서 사용하게 된다. 변경은 불가능(상수로 캡쳐)
        
        // number = 50 // 클로저에서 number = 50으로 변경한 결과가 외부의 number에도 영향을 미친다.
        print("closure: \(number)")
    }
    
    number = 100
    closure()
    print("2: \(number)")
}

firstClosure()

class User {
    var nickname = "JD"
    
    // 클로저에서 순환참조를 피하기 위해서 [weak self]를 사용한다.
    lazy var introduce: () -> String = { [weak self] in
        return self?.nickname ?? ""
    }
    
    deinit {
        print("User Deinit")
    }
}

var user: User? = User()
user?.introduce()
user = nil
