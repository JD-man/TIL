# Starting with the Protocol

## Property Requirement
- 프로토콜에서 타입프로퍼티 요구도 가능
```swift
protocol ChapterOneProtocol {
  static var typeProperty: String { get }
}

struct ChapterOneStruct: ChapterOneProtocol {
  static var typeProperty: String = "Chapter 1 typeProperty"
}

print(ChapterOneStruct.typeProperty)
```

## Method Requirement
- 파라미터의 기본값을 넣지는 못한다.
- 타입 메서드 요구도 가능
```swift
protocol ChapterOneProtocol {
  static func typeMethod() -> Void
}

struct ChapterOneStruct: ChapterOneProtocol {
  static func typeMethod() {
    print("Chapter 1 typeMethod")
  }
}
```
- mutating 사용 가능
```swift
protocol ChapterOneProtocol {
  mutating func mutatingFunc() -> Void
  
}

struct ChapterOneStruct: ChapterOneProtocol {
  mutating func mutatingFunc() {
    print("mutating some property")
  }
}

class ChapterOneClass: ChapterOneProtocol {
  func mutatingFunc() {
    print("fix시 알아서 mutating 제거돼서 나옴")
  }
}
```
- 클래스에서 채택시 mutating 생략 가능

## Protocol Composition
- POP의 매우 중요한 컨셉
- OOP에서 클래스 하이어라키를 만드는 것과 달리 여러개의 프로토콜을 만들어서 조합하는 개념
#### OOP
- Athlete -> Amateur -> AmFootballPlayer, AmBaseBallPlayer
- 위의 클래스 하이어라키가 있는 경우 Pro를 만들기 위해서 Athlete 부터 다시 상속받아야함.
- Pro, Amateur 사이에 많은 중복 코드들이 있을 수 있다.

#### POP
- Athlete, Amateur, Pro, FootballPlayer, BaseBallPlayer 프로토콜을 만듬
- 이 프로토콜들 중 몇개를 다중 채택해서 타입을 만들 수 있음.
- 스위프트를 포함하는 상속이 1번만 가능한 언어에서는 POP 처럼 못함.
- 하지만 너무 프로토콜이 세분화 되지 않도록 주의가 필요.

## Polymorphism
- 파라미터 또는 리턴 타입을 프로토콜로 하는 경우 그 프로토콜을 채택한 타입을 파라미터, 리턴 타입으로 사용할 수 있다.
- Array의 경우에도 프로토콜을 채택한 타입이라면 append 등이 가능하다.
- 프로토콜 상속의 경우에도 동일하게 적용된다.