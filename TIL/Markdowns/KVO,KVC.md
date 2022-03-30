# KVC, KVO

## KVC - Key Value Coding

- Key-Value Coding의 약자
- key 또는 keypath를 통해 간접적으로 값을 읽거나 수정
- key는 String이며 메서드 또는 인스턴스 변수의 이름이다.
- 값의 수정도 가능하다. (구조체나 프로퍼티가 var인 경우 등)

```swift
struct A {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct B {
    var a: A
    
    init(a: A) {
        self.a = a
    }
}

let testA = A(name: "A")
let testB = B(a: testA)

let nameFromTestA = testA[keyPath: \.name]
let nameFromTestB = testB[keyPath: \.a.name]

print(nameFromTestA)
print(nameFromTestB)

// KeyPath 생성해서 사용
let keyPath = \B.a.name

var nameFromTestBWithKeyPath = testB[keyPath: keyPath]
nameFromTestBWithKeyPath = "Changed A"
print(nameFromTestBWithKeyPath) // Changed A
print(testB[keyPath: keyPath]) // A
// 구조체의 값을 변경하려면 키패스로 직접 접근해야한다
```

---

## KVO - Key Value Observing

- Key-Value Observing
- 객체의 변경사항을 다른 객체에 알리기 위해 사용. 클래스여야 한다!.
- NSObject 상속, observe 하려는 프로퍼티에 @objc dynamic을 붙인다.
- observe하려는 프로퍼티는 키패스를 통해 접근한다.
- 확인하려면 변경사항을 options에 작성한다.
- 클래스 인스턴스에 observe 메서드를 사용해서 관찰한다.
- 모델, 뷰의 동기화에 좋다. 키패스 접근방식이므로 인스턴스가 다른 인스턴스의 프로퍼티로서 @objc dynamic으로 선언되어 있으면 nested 방식으로 접근 가능. (ex: ./address.town)
- 

```swift
// KVC와 다르게 클래스여야함. NSObject 사용을 위해서
class A: NSObject {
    @objc dynamic var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct B {
    var name: String
}

var testA = A(name: "A")
var testB = B(name: "B")

print("Before: ", testB.name) // Before: B

testA.observe(\.name, options: [.new, .old]) { object, value in
    testB.name = value.newValue ?? ""
}

testA.name = "Changed B"
print("After: ", testB.name) // After:  Changed B
```