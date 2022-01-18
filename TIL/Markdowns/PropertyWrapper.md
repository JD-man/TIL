# Property Wrappers

## 목차
1. 의의
2. 초기값 설정
3. Projected Value

---

## 1. 의의
- 프로퍼티가 어떻게 저장되는지와 어떻게 정의되는지를 나눠준다.
- wrapper를 정의할때 코드를 한번만 쓰고 여러 프로퍼티에서 돌려쓰기 가능.
- 역할이나 동작이 같은 프로퍼티에 사용하기 편하다.

### 1) 정의
```swift
@propertyWrapper
struct TwelveOrLess {
    private var number = 0
    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, 12) }
    }
}
```
- 구조체, 열거형, 클래스에서 @propertyWrapper를 이용해 정의한다.
- 위의 TwelveOrLess 구조체는 값이 12이하로만 가지게 한다.
- 프로퍼티의 저장 : 12이하로만, 프로퍼티의 정의 : 저장된 프로퍼티값(number)
- wrappedValue에만 접근이 필요하므로 number는 private이다.

### 2) 사용
```swift
struct SmallRectangle {
    @TwelveOrLess var height: Int
    @TwelveOfLess var width: Int
}

var rectanlge = SmallRectangle()
print(rectangle.height) // 0

rectangle.height = 10
print(rectangle.height) // 10

rectangle.height = 24
print(rectangle.height) // 12
```

- 사용하고자하는 프로퍼티 앞에 @와 이름을 붙여준다.
- @TwelveOrLess wrappedValue가 height, width같은 프로퍼티를 덮어쓴다고 생각하면 편하다.
- height, width는 @TwelveOrLess에 있는 number의 초기값을 받는다 (0)
- @TwelveOrLess setter는 height를 12이하로 저장되게 제한한다.

- Property Wrapper를 적용할때 컴파일러는 wrapper 저장코드와, wrapper를 통한 접근코드를 합성한다.
- 합성을 위한 코드가 필요없다.

### 3) 이점
- 특별한 속성 문법을 이용하지 않아도 Property Wrapper를 사용하는 코드를 작성할 수 있다.
- 위의 SmallRectangle은 @propertyWrapper를 사용하지 않으면 아래와 같다.

```swift
struct SmallReectangle {
    private var _height = TwelveOrLess()
    private var _width = TwelveOrLess()

    var height: Int {
        get { return _height.wrappedValue }
        set { _height.wrappedValue = newValue }
    }
    var width: Int {
        get { return _width.wrappedValue } 
        set { _width.wrappedValue = newValue }
    }    
}
```

- height, width는 저장된 값으로 정의되며 저장시 상한이 필요하다는 공동점이 있다.
- Property Wrapper는 프로퍼티의 정의와 저장을 관리하기 때문에 이런 상황에 용이하다.

---

## 2. 초기값 설정

### 1) 문제점
- 지금의 TwelveOrLess는 number가 0으로 초기값을 가지고 있다.
- 이런 상태로는 height과 width에 다른 초기값을 줄 수 없다.

### 2) 방법 : initializer 추가
- 다른 초기값을 가지는 등의 커스터마이즈를 위해서 Property Wrapper에 initializer를 추가해야한다.
```swift
@propertyWrapper
struct SmallNumber {
    private var maximum: Int
    private var number: Int

    var wrappedValue: Int {
        get { return number }
        set { number = min(newValue, maximum) }
    }

    init() {
        maximum = 12
        number = 0
    }

    init(wrappedValue: Int) {
        maximum = 12
        number = min(wrappedValue, maximum)
    }

    init(wrappedValue: Int, maximum: Int) {
        self.maximum = maximum
        number = min(wrappedValue, maximum)
    }
}
```

- wrappedValue와 maximum을 설정하는 initializer들이 작성되어있다.

### 3) 사용
3)-1. 그냥 사용
```swift
struct ZeroRectanlge {
    @SmallNumber var height: Int
    @SmallNumber var width: Int
}

var zeroRectangle = ZeroRectangle()
print(zeroRectangle.height, zeroRectangle.width) // 0, 0
```

- 별다른 초기값을 설정하지 않는다면 SmallNumber의 init()이 사용된다.
- SmallNumber의 instance가 생성되고 height와 width를 감싼다.(wrap)

3)-2. 프로퍼티에 초기값 설정
```swift
struct UnitRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber var width: Int = 1
}

var unitRectangle = UnitRectangle()
print(unitRectangle.height, unitRectangle.width) // 1, 1
```

- 프로퍼티에 초기값을 넣으면 init(wrappedValue:)가 사용된다.
- 책 표현으로는 프로퍼티에 적은 '= 1'은 init(wrappedValue:)로 translate된다고 한다.
- SmallNumber는 SmallNumber(wrappedValue: 1)로 생성되고 프로퍼티를 감싼다.
- maximum은 정의된대로 12를 사용한다.

3)-3. propertyWrapper 매개변수 사용
```swift
struct NarrowRectangle {
    @SmallNumber(wrappedValue: 2, maximum: 5) var height: Int
    @SmallNumber(wrappedValue: 3, maximum: 4) var width: Int
}

var narrowRectangle = NarrowRectangle()
print(narrowRectangle.height, narrowRectangle.width) // 2, 3

narrowRectangle.height = 100
narrowRectangle.width = 100
print(narrowRectangle.height, narrowRectangle.width) // 5, 4
```

- @SmallNumber를 붙일때 매개변수와 같이 붙인다면 init(wrappedValue:, maximum:)을 사용한다.
- 이렇게하면 wrapper마다 다르게 설정이 가능!!!  

3)-4 섞어쓰기

```swift
struct MixedRectangle {
    @SmallNumber var height: Int = 1
    @SmallNumber(maximum: 9) var width: Int = 2    
}

var mixedRectangle = MixedRectangle()
print(mixedRectangle.height) // 1

mixedRectangle.height = 20
print(mixedRectangle.height) // 12

```
- wrappedValue 같은 것은 할당을 이용해서 초기값을 설정할 수 있다.

---

## 3. Projected Value
### 1) 의의
- projectedValue를 사용해서 프로퍼티의 추가적인 기능을 알 수 있다.
- 프로퍼티의 앞에 $를 붙여서 사용한다.
- 작성하는 코드에 $가 들어간 프로퍼티를 정의할 수 없으므로 내가 작성한 코드에 의해 방해받지 않는다.


### 2) 예시
```swift
@propertyWrapper
struct SmallNumber {
    private var number = 0
    var projectedValue = false
    var wrappedValue: Int {
        get { return number }
        set {
            if newValue > 12 {
                number = 12
                projectedValue = true
            }
            else {
                number = newValue
                projectedValue = false
            }
        }
    }
}

struct SomeStructure {
    @SmallNumber var someNumber: Int
}

var someStructure = SomeStruecture()

someStructure.someNumber = 4
print(someStructure.$someNumber) // false

someStructure.someNumber = 55
print(someStructure.$someNumber) // true
```

- 이전의 SmallNumber는 상한을 제한했지만 그 값이 수정된 값인지 아닌지 알 수 없었다.
- 프로퍼티에 $를 붙이면 projectedValue에 접근할 수 있으며 예시의 경우 수정된 값인지 알 수 있다.

### 3) 그냥 프로퍼티처럼 사용 가능
```swift
enum Size {
    case small, large    
}

struct SizedRectangle {
    @SmallNumber var height: Int
    @SmallNumber var width: Int

    mutating func resize(to size: Size) -> Bool {
        switch size {
        case .small:
            height = 10
            width = 20
        case .large:
            height = 100
            width = 100
        }
        return $height || $width
    }
}
```

- projectedValue는 다양한 타입으로 리턴할 수 있다. 다른 타입의 인스턴스도 가능.
- 예시는 하나의 Bool만 리턴하는 것.
- 위의 resize 메서드처럼 $을 붙이면 일반프로퍼티 같이 사용할 수 있다.