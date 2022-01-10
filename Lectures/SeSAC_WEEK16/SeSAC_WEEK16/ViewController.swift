//
//  ViewController.swift
//  SeSAC_WEEK16
//
//  Created by JD_MacMini on 2022/01/10.
//

import UIKit

// 클래스만 이 프로토콜을 채택할 수 있게함
protocol myProtocol: AnyObject {
    
}

enum GameJob {
    case warrior
    case rogue
}

class Game {
    var level = 5
    var name = "도사"
    var job: GameJob = .warrior
}

class ViewController: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //copyOnWrite()
        aboutSubscript()
        //aboutForEach()
    }
    
    // AnyObject vs Any
    // 런타임 시점에 타입이 결정. 컴파일 시점에서 알 수 없음.
    
    // Any: Class, Struct, Enum, Closure ...
    // AnyObject: Class
    
    func anyAnyObject() {
        let name = "고래밥"
        let gender = false
        let age = 10
        let character = Game()
        
        let anylist: [Any] = [name, gender, age, character]
        let anyObjectList: [AnyObject] = [character]
        print(anylist, anyObjectList)
        
        // 타입캐스팅이 필요하다. 아니면 런타임 오류
        if let value = anylist[0] as? String {
            print(value)
        }
    }
    
    @IBAction func buttonClicked(_ sender: Any) {
        // Any 타입이므로 UIButton의 currentTitle을 사용할 수 업음
        //print(sender.currentTitle)
        
        // 특별한 UI 인스턴스를 사용하는게 아니라면 여러 UI에 사용
        print("clicked")
        view.endEditing(true)
    }
    
    // Copy On Write
    func copyOnWrite() {
        // Struct: 값타입. 메모리에서 복사가됨.
        
        // 메모리 구조
        // Code | Data | Heap | Stack
        
        // Code : 작성해놓은 코드들. 읽기만 가능하고 수정은 불가능.
        // Data : 앱 시작 - 종료까지 메모리상에 계속 남는 데이터. 전역변수/Static 등. 수정까지 가능
        
        
        // Stack : 임시 메모리 영역. 매개변수, 반환값. 함수가 종료되면 알아서 정리됨. LIFO
        // Heap : 직접 해제 해야함. 메모리 누수 발생. 참조타입이 저장됨.
        
        // Stack과 Heap은 물리적으로 나누어진건 아니고 공유되어있음
        // Heap은 낮은 주소값. Stack은 높은 주소값.
        
        
        
        var nickname = "JD"
        print(address(of: &nickname))
        
        // String은 구조체이므로 복사함.
        // nickname과 다른 주소를 가짐
        var nicknameByFamily = nickname
        print(address(of: &nicknameByFamily))
        
        // 여기서 변경해도 nickname 자체는 변경 안됨.
        nicknameByFamily = "조동"
        print(address(of: &nicknameByFamily))
        
        print(nickname, nicknameByFamily)
        
        
        // Array도 구조체
        var array = Array(repeating: 100, count: 100)
        print(address(of: &array))
        
        var newArray = array
        print(address(of: &newArray)) // newArray는 array와 주소가 같음!!!
        newArray[0] = 0
        print(address(of: &newArray)) // 여기는 다르다
        
        
        // Array에 데이터가 많아질 수 있는 상태
        // 수정되기 전까지는 원본을 공유하다가 원본과 데이터가 다르게되는 순간에 데이터를 복사한다. Copy On Write
        // 메모리를 효율적으로 사용하기 위함
        // 이런 현상은 Collection Type에서 발생함.
        
        
        // Class의 경우
        
        var game = Game()
        var newGame = game
        
        newGame.level = 595
        
        print(game.level, newGame.level) // 595 595. newGame의 level만 변경했는데 둘다 바뀜
        
        // heap에는 game, newGame 클래스 인스턴스와 인스턴스 정보 주소 저장
        // stack에는 인스턴스 정보 level 등 저장
        
        // Collection Type : Collection protocol 채택하는 자료형
        // 구조체지만 힙에 저장된다.. 데이터 크기가 클 수 있기 때문임.
        // 값타입이지만 힙에 저장되는 경우
        
    }
    
    func address(of object: UnsafeRawPointer) -> String {
        let address = Int(bitPattern: object)
        return String(format: "%p", address)
    }
    
    
    // CollectionType: Collection, Sequence, Subscript
    func aboutSubscript() {
//        let array = [1,2,3,4,5]
//        print(array[2])
//
//        let dict = ["도사" : 595, "도적" : 594]
//        print(dict["도사"])
        
        // subscript: []을 통한 접근
        
//        let str = "Hello World"
//        print(str[-1])
//        print(str[0])
//        print(str[2])
//        print(str[7])
//        print(str[10])
//        print(str[11])
//        print(str[199])
        
        
        struct UserPhone {
            var numbers = ["11111", "22222", "33333"]

            subscript(idx: Int) -> String? {
                get {
                    guard (0 ..< numbers.count).contains(idx) else {
                        return nil
                    }
                    return numbers[idx]
                }
                set {
                    guard (0 ..< numbers.count).contains(idx) else {
                        return
                    }
                    self.numbers[idx] = newValue ?? ""
                }

            }
        }

        var value = UserPhone()
        print(value[0])
        value[0] = "변경"
        print(value[0])
    }
    
    func aboutForEach() {
        // for-in : break, continue 흐름 제어 가능
        let array = [1,2,3,4,5,6,7,8,9]
        for i in array {
            if i == 5 {
                print("break")
                break
            }
            print("for-in: ", i)
        }
        
        // forEach : 흐름제어 업음
        array.forEach { i in
            print("forEach: ", i)
        }
    }
    
    //@frozen
    //Unfrozen Enumeration: 계속 추가 될 수 있는 가능성을 가진 열거형
    func aboutEnum() {
        // Optional의 경우 @frozen이 있다! @frozen을 사용하면 컴파일 단계에서 확인가능하므로 최적화 가능
        // @frozen은 프레임워크나 라이브러리에서 주로 사용
        
//        let size = UIUserInterfaceSizeClass.compact // 얘는 @frozen없음
//        switch size {
//        case .unspecified:
//            <#code#>
//        case .compact:
//            <#code#>
//        case .regular:
//            <#code#>
//        @unknown default:
//            break
//        }
        
        
        // Attribute: @objc, @frozen, @available 같이 @ 붙은거
        // Decalaration : @available, @discardableResult, @propertyWrapper
        // Type : @escaping, @autoClosure
        // Swift 문서에 있음!
    }
}

extension String {
    subscript(idx: Int) -> String? {
        if idx == -1 {
            return String(self.reversed())
        }
        guard idx > 0, idx < count else {
            return nil
        }
        let result = index(startIndex, offsetBy: idx)
        return String(self[result])
    }
}
