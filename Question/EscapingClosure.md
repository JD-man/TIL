# Escaping Closures

## 목차
1. 의의
2. 사용
3. 유의점

---

## 1. 의의
- 함수의 인수로서 클로저가 사용될때 @escaping을 사용할 수 있다.
- escape된다는 것은 함수의 외부에서 사용할 수 있다는 얘기다.
- 클로저는 그 함수가 리턴되고 나서 호출된다.
- 비동기 실행이 끝나고 난 후에 실행될 completion handler로서 주로 사용된다.

--- 

## 2. 사용
```swift
// completion을 저장할 외부변수
var completions: [() -> Void] = []

// 클로저를 함수 외부에서 사용하려고 했기 때문에 컴파일 에러가 나온다.
func withNonEscaping(completion: () -> Void) {
    completionHandlers.append(completion)
}

// @escaping을 붙여줘서 탈출하게 해준다.
func withEscaping(completion: @escaping () -> Void) {
    completionHandlers.append(completion)
}

```

---

## 3. 유의점

- 함수 외부에서 저장하고 사용되고 클로저는 강한참조하므로 메모리 관리가 필요하다.
- self를 사용할때는 weak self를 사용하는 것이 좋다.
