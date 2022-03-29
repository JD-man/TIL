# Optional

## 목차
1. 정의
2. 구현된 방식
3. 사용

---

## 1. 정의
- Wrapped value 또는 nil을 사용하는 타입
- Wrapped value는 Optional로 감싸진 Generic 타입의 어떤 값을 말한다.
- nil은 아무런 값이 없는것을 말한다.

---

## 2. 구현된 방식
- Optional 타입은 2가지 케이스를 가지는 열거형이다.
- Optional.none과 Optional.some이며 .some의 경우 저장할 wrapped value를 작성한다.

```swift
let number: Int? = Optional.some(42) // Optional(42)
let noNumber: Int? = Optional.none // nil

```

---

## 3. 사용
- 타입으로 사용
```swift
let shortForm: Int? = Int("42") // Optional(42)
let longForm: Optional<Int> = Int("42") // Optional(42)

// Int? == Optional<Int>
```

- wrapped value의 사용 : Optional Binding, Optional Chaining, ?? , !
