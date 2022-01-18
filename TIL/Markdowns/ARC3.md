# Automatic Reference Counting 3

- 클로저 편

## 목차
1. 클로저에서 발생하는 **강한 참조**
2. self를 참조하는 클로저의 Strong Reference Cycle
3. 클로저 Strong Reference Cycle 피하기

---

## 1. 클로저에서 발생하는 **강한 참조**
- 클래스 인스턴스의 프로퍼티에 클로저를 할당하고 클로저가 인스턴스를 캡쳐한다면 Strong Reference Cycle이 발생한다.
- 클로저도 참조타입이기 때문에 이런 현상이 발생한다.

---


## 2. self를 참조하는 클로저의 Strong Reference Cycle
```swift
class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        }
        else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())
// <h1>default text</h1> 출력
```

- asHTML은 클로저 프로퍼티로서 사용된다.
- 따라서 초기값으로 설정된 클로저를 변경할 수 있다.

```swift
var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello, world")

// paragraph -> HTMLElement Instance +1
// paragraph.asHTML -> closure +1
// closure -> HTMLElement Instance +1
```

- 위처럼 만들어진 HTMLElement 클래스는 asHTML 클로저와 Strong Reference Cycle을 만든다.
- 클로저의 내부에 사용된 self가 캡쳐되고 **강한 참조**를 만든다.
- 클로저 내부에 캡처를 여러번하더라도 1개의 **강한 참조**만 생긴다.
- paragraph = nil을 해도 deinit이 호출되지 않는다. Strong Reference Cycle가 발생해서.

---

## 3. 클로저 Strong Reference Cycle 피하기

```swift
lazy var someClosure = {
    [unowned self, weak delegate = self.delegate] in
    // body...
}
```

- 캡쳐 리스트를 정의해서 해결할 수 있다. 클로저 내부 첫시작부터 []을 이용해 작성한다.
- 캡쳐 리스트는 어떻게 참조할지 방식을 결정한다.
- 캡쳐된 참조클래스가 nil이 될일이 없다면 unowned로 아니면 weak으로 작성한다.


```swift
lazy var asHTML: () -> String = { [unowned self] in
    if let text = self.text {
        return "<\(self.name)>\(text)</\(self.name)>"
    }
    else {
        return "<\(self.name) />"
    }
}
```
- 위의 예제에서 [unowned self] 캡쳐리스트를 만들면 해결된다. self를 unowned 참조하겠다는 뜻
- asHTML이 사용되는한 self는 계속 살아있으므로 unowned를 사용한다.

```swift
paragraph = nil
// p is being deinitialized
```

- 위에서 안됐던 HTMLElement p 인스턴스가 해제된다.
