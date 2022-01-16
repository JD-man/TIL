# Autoclosure

## 목차
1. 의의
2. @autoclosure

---

## 1. 의의
- 함수에 인수로 전달되는 표현식을 래핑하기 위해 생성된 클로저
- **어떠한 인수도 받지 않고** 래핑한 표현식의 리턴값을 리턴한다
- @autoclosure 사용으로 {}도 생략가능!!

```swift
assert(condition:message:file:line:)
```
- 위의 assert 함수는 condition과 message에 autoclosure를 받는다.

```swift
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print(customersInLine.count) // 5

let customerProvider = { customersInLine.remove(at: 0) }
print(customersInLine.count) // 5

print("Now serving \(customerProvider())") // Now serving Chris
print(customersInLine.count) // 4
```

- autoclosure안에 들어있는 코드는 closure를 호출하기 전에는 실행되지 않는다.
- customerProvider안에 있는 customersInLine.remove(at: 0) 코드는 곧바로 실행되지 않는다.
- customerProvider의 타입은 String이 아니며 () -> String이다.
- 인수도 받지 않고 래핑한 customerInLine.remove의 리턴값을 리턴한다!!

```swift
func serve(customer customerProvide: () -> String) {
    print("Now serving \(customerProvider())")
}

serve(customer: { customersInLine.remove(at: 0) })
// Now serving Alex
```

- 함수의 인자로 들어갈때도 마찬가지다.

---

## 2. @autoclosure
- 함수의 파라미터에 @autoclosure attribute을 사용하면 {}없이 클로저 사용이 가능하다.
- 내부적으로는 () -> String을 받지만 그냥 String을 받는거 처럼 사용 가능.

```swift
func serve(customer customerProvide: @autoclosure () -> String) {
    print("Now serving \(customerProvider())")
}

serve(customer: customersInLine.remove(at: 0))
// Now serving Ewa
```

- @autoclosure 작성 위치는 @escaping 처럼 파라미터 타입 작성 전이다.
- 하지만 코드를 이해하기 힘들 수 있으니 적당히 사용하라고 한다.

```swift
var customerProviders: [() -> String] = []
func collectionCustomerProviders(_ customerProvider: @autoclosure @escaping () -> String) {
    customerProviders.append(customerProvider)
}

// escaping autoclosure
collectionCustomerProviders(customersInLine.remove(at:0))
collectionCustomerProviders(customersInLine.remove(at:0))

print("Collected \(customerProviders.count) closures.")

for customerProvider in customerProviders {
    print("Now serving \(customerProvider())")
}

/*
Collected 2 closures.
Now serving Barry
Now serving Daniella
*/
```

- @escaping과 연계해서 사용도 가능!