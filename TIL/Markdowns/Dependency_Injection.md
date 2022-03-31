# 의존성 주입, 의존성 역전

## 목차
1. 의존성
2. 의존성 주입
3. 의존성 역전

---

## 1. 의존성
```swift
class Label {
    var name: String = "My Basket"

    func printLabel() {
        print(name)
    }
}

class Basket {
    var label = Label()

    func printLabel() {
        label.printLabel()
    }
}

let basket = Basket()
print(basket.label.name)
```

- 바구니 안에 라벨이 있다고 하면 Basket은 내부에 Label 클래스의 인스턴스인 label을 가진다.
- 이 때 Basket은 Label에 의존성이 생긴다.
- Label은 Basket의 상위 클래스로서 재사용이 가능하다.
- 만약 상위 클래스 Label에 문제가 생긴다면 Basket 클래스에도 문제가 생기므로 이런 의존성은 문제될 수 있다.

---

## 2. 의존성 주입
```swift
class Label {
    var name: String = "My Basket"
    
    func printLabel() {
        print(name)
    }
}

class Basket {
    var label: Label
    
    init(label: Label) {
        self.label = label
    }
    
    func printLabel() {
        label.printLabel()
    }
}

let basket = Basket(label: Label())
basket.printLabel()
```

- 주입이란 외부에서 객체를 생성해서 넣어주는 것을 말한다.
- 의존성 주입은 위의 코드처럼 의존성이 있는 부분을 외부에서 객체를 생성해서 넣어주는 것을 말한다.

---

## 3. 의존성 역전
```swift
protocol LabelType {
    var name: String { get set }
    
    func printLabel()
}

class Basket {
    var label: LabelType
    
    init(label: LabelType) {
        self.label = label
    }
    
    func printLabel() {
        label.printLabel()
    }
}
```

- 의존성 역전은 구체적인 것은 추상회된 것에 의존해야 한다는 SOLID 법칙 중 하나다.
- Swift에서는 Protocol을 이용해서 주로 구현한다.
- 위의 예시처럼 Basket은 Label 클래스 없이 Protocol만을 이용해서 구현이 가능하다.

```swift
class Label: LabelType {
    var name: String = "My Basket"
    
    func printLabel() {
        print(name)
    }
}
```

- 이제 Label 클래스는 LabelType을 채택한다.
- 따라서 이제 Basket 클래스가 가지고 있는 LabelType에 Label 클래스가 의존하게되며 이렇게 의존성이 역전된다.
- 이렇게하면 하나의 객체 수정시에 다른 객체도 수정해야하는 상황을 방지할 수 있다.