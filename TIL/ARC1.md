# Automatic Reference Counting 1
- 참고자료 : The Swift Programming Language

## 목차
1. 의의
2. 동작방식
3. 예시
4. 클래스간 강한참조순환

---

## 1. 의의
- 스위프트는 ARC를 통해 알아서 앱의 메모리를 관리한다.
- 하지만 몇몇의 상황 때문에 코드상으로 더 정확한 정보가 필요하다.
- 앞으로 계속 작성할 ARC 정리들은 그런 상황들을 다룬다.
- Reference Counting은 클래스 인스턴스에만 적용된다. 구조체, 열거형은 값타입이라서 적용안됨.

---

## 2. 동작방식
- 클래스의 인스턴스를 생성할때마다 ARC는 인스턴스의 정보들을 메모리에 저장한다.
- 생성한 인스턴스가 필요 없어지면 ARC는 그 인스턴스를 메모리에서 제거한다.
- 만약 ARC가 계속 필요한 인스턴스를 메모리에서 해제해버린다면 그 인스턴스의 프로퍼티, 메서드 등에 접근할 수 없다.
- ARC는 인스턴스가 계속 필요한지 확인하기 위해서 변수 또는 상수 등이 인스턴스를 참조하고 있는지 체크한다.
- 인스턴스를 단순히 참조하고 있는 변수 또는 상수 등은 **강한 참조**한다.
- **강한 참조**가 있는 이상 인스턴스는 메모리 해제가 되지 않는다.

---

## 3. 예시
```swift
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    deinit {
        print("\(name) is being deinitialzed")
    }
}
```

- Person 클래스는 생성과 함께 name을 설정하고 생성됐다는 print를 찍는다.
- 메모리에서 해제됐을때도 print를 찍는다.

```swift
var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "JD")
// JD is being initialized 프린트됨
```

- 3개의 옵셔널 Person을 만든다. nil값이 처음에 들어가므로 인스턴스를 참조하고 있지 않다.
- Person 인스턴스를 생성하고 reference1에 할당하면 생성됐다는 프린트가 찍힌다.
- reference1에 대한 **강한 참조**가 생긴다.

```swift
reference2 = reference1
reference3 = reference1
```

- reference2,3에 각각 reference1을 할당해 참조시키면 **강한 참조**는 2개 더 늘어난다.
- 현재 총 3개의 **강한 참조**가 있다.

```swift
reference1 = nil
reference2 = nil
```

- reference1,2 두개를 nil해도 **강한 참조** 1개가 남아 있어서 Person의 인스턴스는 메모리에서 해제되지 않는다.

```swift
reference3 = nil
// JD is being deinitialzed 프린트됨
```

- 남아있는 reference3까지 nil로 만들어 **강한 참조**를 없애주면 Person의 인스턴스는 메모리에서 해제된다.

---

4. 클래스간 강한참조순환

- Strong Reference Cycle : 두 클래스의 인스턴스가 서로 강한참조하는 상황. 모두 메모리에서 해제되지 않는다.

```swift
class Person {
    let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var apartment: Apartment?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

class Apartment {
    let unit: String
    
    init(unit: String) {
        self.unit = unit
    }
    
    var tenant: Person?
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}
```

- Person 클래스는 Apartment 타입의 프로퍼티가 있고, Apartment에는 Person 타입의 프로퍼티가 있다.
- 둘다 옵셔널로 처음엔 nil값을 가지고 있다.

```swift
var jd: Person?
var unit4A: Apartment?

jd = Person(name: "JD") // JD +1
unit4A = Apartment(unit: "4A") // 4A +1
```

- jd와 unit4A 변수를 만들고 각각 인스턴스를 할당한다.
- jd는 Person 인스턴스 JD의 **강한 참조**를 1 증가시킨다.
- unit4A는 Apartment 인스턴스 4A의 **강한 참조**를 1 증가시킨다.

```swift
jd!.apartment = unit4A // 4A +1
unit4A!.tenant = jd // JD +1
```

- **인스턴스의 프로퍼티**가 각각 인스턴스의 **강한 참조**를 1 증가시켰다.
- 이 경우 Strong Reference Cycle가 발생한다.

```swift
jd = nil // JD -1
unit4A = nil // 4A -1

// 여기까지 계산하면 JD = 1, 4A = 1로 강한 참조가 1씩 남아있다.
// deinitializer가 호출되지 않는다.
```

- 여기서 변수들에 nil을 줘서 **강한 참조**를 1 감소시켜도 인스턴스 내부에서 서로 참조하고 있어 0이 되지 않는다.
- 인스턴스들은 메모리에 계속 남아있어 Memory Leak을 발생시킨다.
