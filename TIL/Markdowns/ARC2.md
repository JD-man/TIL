# Automatic Reference Counting 2
- 클래스간 강한참조순환 해결하기

## 목차
1. weak
2. unowned
3. unowned optional
4. unowned & Unwrapped Optional Property

---

## 1. weak
- weak을 사용하면 **강한 참조**를 하지 않고 **약한 참조**한다.
- 아직 참조 중인 **약한 참조**가 있더라도 ARC는 메모리 해제를 할 수 있다.
- weak은 라이프타임이 더 짧은 것에 사용하는게 좋다.
- 런타임때 언제든지 nil이 될 수 있어야 하므로 optional variable로 사용한다.
- nil이 된 경우 프로퍼티 감시자는 호출되지 않는다!

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
    
    weak var tenant: Person?
    
    deinit {
        print("Apartment \(unit) is being deinitialized")
    }
}
```

- 이전편에서 사용했던 Person과 Apartment이지만 Apartment의 tenant에 weak이 붙었다.
- weak은 라이프타임이 더 적은거에 붙는다고 했는데 건물보다 사람이 먼저가서 사람에 weak이 붙음 ㄷㄷㄷ

```swift
var jd: Person? = Person(name: "JD") // Person JD +1
var unit4A: Apartment? = Apartment(unit: "4A") // Apartment 4A +1

jd!.apartment = unit4A // Apartment 4A +1
unit4A!.tenant = jd // Person JD +0 (weak!)

jd = nil // Person JD -1

// Person JD 강한참조 카운트 = 0
// JD is being deinitialized 출력된다. -> Apartment 4A -1
```

- 이전편과 다르게 jd에 nil을 주면 Person JD 인스턴스의 강한참조 카운트가 0이되고 메모리 해제가 된다!!
- 메모리에서 해제되면서 jd.apartment의 Apartment 4A 인스턴스에 대한 **강한 참조**가 없어졌다.

```swift
print(unit4A!.tenant) // nil
unit4A = nil // Apartment 4A is being deinitialized
```

- JD가 메모리에서 없어져서 unit4A의 tenant는 nil이 됐다.
- 이 상태에서 unit4A에 nil을 주면 Apartment 4A 인스턴스의 강한참조 카운트는 0이되고 메모리 해제가 된다.

### GC vs ARC
- 가비지콜렉터는 memory pressure가 있을 때만 강한참조가 없는 인스턴스가 해제된다.
- ARC는 마지막 강한참조가 사라지자마자 메모리에서 해제된다.

---

## 2. unowned
- weak과 비슷한 효과를 가지고 있다.
- 하지만 다른 인스턴스와 비교해 같거나 더 긴 라이프타임을 가지는 것에 사용한다.
- unowned가 붙으면 값을 항상 가지고 있으며 optional이 아니다. 런타임중 nil이 되지 않는다.
- 이미 해제된 인스턴스를 unowned로 참조하고 있으면 런타임 에러가 나므로 주의!

```swift
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        print("Customer \(name) is initialized")
        self.name = name
    }
    deinit {
        print("Customer \(name) is deinitialized")
    }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer // unowned는 optional이 아니다.
    init(number: UInt64, customer: Customer) {
        print("CreditCard \(number) of Customer \(customer.name) is initialized")
        self.number = number
        self.customer = customer
    }
    deinit {
        // deinit에서 customer에 접근하면 오류가 발생함
        print("CreditCard \(number) is deinitialized")
    }
}
```

- Customer는 CreditCard를 가지고 있을수도 있고 없을수도 있다.
- 하지만 CreditCard는 항상 사용하는 Customer가 있다. Customer보다 먼저 메모리 해제되지 않는다.
- 그리고 CreditCard는 Customer 인스턴스 없이는 생성될 수 없다.
- 따라서 CreditCard는 무조건 Customer를 가지고 있으므로 unowned를 사용할 수 있다.

```swift
var jd: Customer? = Customer(name: "JD") // Customer JD +1
jd!.card = CreditCard(number: 1234, customer: jd!) // CreditCard 1234 +1

// CreditCard의 customer에 의한 참조는 unowned이므로 +1되지 않음

jd = nil // Customer JD -1

// Customer JD Reference Count = 0 -> deinit -> CreditCard 1234 -1
// CreditCard 1234 Reference Count = 0

// 출력
/*
Customer JD is initialized
CreditCard 1234 of Customer JD is initialized
Customer JD is deinitialized
CreditCard 1234 is deinitialized
*/
```

- Customer JD에 **강한 참조**가 0이되고 타고타고가서 CreditCard에 대한 **강한 참조**도 0이 되므로 둘다 해제된다.
- JD하나만 메모리해제해도 둘다 해제되는게 특징
- 하지만 안전하지 않을 수 있으므로 코드를 조심히 작성하고 확인해야한다.

---

## 3. unowned optional

```swift
class Department {
    var name: String
    var courses: [Course]
    init(name: String) {
        self.name = name
        self.courses = []
    }
}

class Course {
    var name: String
    unowned var department: Department
    unowned var nextCourse: Course?
    init(name: String, in department: Department) {
        self.name = name
        self.department = department
        self.nextCourse = nil // 이거 없어도 동작은 됨. nil값을 가져야하는걸 명확히 표시
    }
}

let department = Department(name: "JD")

let intro = Course(name: "Intro", in: department)
let intermediate = Course(name: "Intermediate", in: department)
let advanced = Course(name: "Advanced", in: department)

intro.nextCourse = intermediate
intermediate.nextCourse = advanced

department.courses = [intro, intermediate, advanced]
```

- Optional은 열거형으로 값타입이라 unowned가 붙을 수 없지만 예외적으로 허용된다.
- 동작방식은 weak을 사용할때와 같다고 볼 수 있다. 하지만 unowned optional을 사용한다면 nil을 직접 넣어줘야한다. 안그럼 런타임에러
- 그럼에도 unowned optional을 사용하는 이유는 비용상 이점이 있다고하며,  
  접근제어자 쓰듯이 코드상으로 명확히 어떤 값을 가져야하는지 표현하기 위해서라고 생각된다.

---

## 4. unowned & unwrapped Optional Property
- weak 사용사례 : 두개의 인스턴스 프로퍼티 모두 optional인 경우
- unowned 사용사례 : 둘중 하나의 인스턴스 프로퍼티는 optional이 아닌 경우
- 두개의 프로퍼티 모두 optional이 아닌 경우가 남았다.

```swift
class Country {
    let name: String
    var capitalCity: City!
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}
```

- Country 생성할때 capitalCity에 City 초기화 코드가 있다.
- Country 인스턴스가 모두 초기화 되기 전에는 self를 사용하지 못하지만 capitalCity가 City! 타입이기 때문에 가능.
- City!를 사용해서 초기값은 nil이며 강제 언래핑하므로 바로 접근이 가능하다.
- 따라서 City 생성시 self 사용이 가능하다.

```swift
var country = Country(name: "Canada", capitalName: "Ottawa")
print("\(country.name)'s capital city is called \(country.capitalCity.name)")
```

- Country와 City 인스턴스를 한줄로 생성할 수 있다는 의미가 있다.
- Strong Reference Cycle은 피하면서 capitalCity를 non-optional처럼 사용할 수 있다. 우왕굳