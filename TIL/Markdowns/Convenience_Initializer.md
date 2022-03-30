# Convenience Initializer

## 목차
1. Designated Initializer
2. Convenience Initializer
3. 사용
4. 구조체와의 차이
---

## 1. Designated Initializer
- 클래스의 모든 프로퍼티를 초기화하는 Initializer
- 모든 클래스에서 적어도 한개는 가지고 있다.
- 보통 클래스를 만들때 사용하는 init()

---

## 2. Convenience Initializer
- 클래스의 Initializer를 보조한다.
- Designated Initializer 또는 다른 Convenience Initializer를 호출하기 위해 사용한다.
- 특별한 사용 또는 입력값의 타입을 사용하려고 할때 만든다.

---

## 3. 사용
- convenience init으로 사용한다.
- 클래스 초기화를 내가 하고싶은 방식대로 하는 것이 가능.

```swift
final class BaseTextField: UITextField {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // 플레이스홀더 텍스트를 지정해주고 비밀번호를 사용하는지 여부를 정해서 TextField 초기화.
    convenience init(placeholder: String, isUsingPassword: Bool = false) {
        self.init()
        addBorder()
        addCorner(rad: 5)
        leftViewMode = .always
        autocorrectionType = .no
        autocapitalizationType = .none                
        self.placeholder = placeholder
        isSecureTextEntry = isUsingPassword
        leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        self.attributedPlaceholder = NSAttributedString(string: placeholder,
                                                        attributes: [.font : UIFont.systemFont(ofSize: 12, weight: .medium)])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
```

---

## 4. 구조체와의 차이
- 구조체에서 convenience Init을 사용하려고 하면 **Initializers in structs are not marked with 'convenience'** 에러가 발생.
- 클래스는 상속이 있고 보통 서브클래스에서 super의 이니셜라이저를 실행한다.
- 클래스에서 convenience라고 마크하는 것은 designated init이 아니라는 것과 같다.
- 따라서 서브클래스에서 실행하는 super의 이니셜라이저로 convenience 이니셜라이저가 실행될 수 없게 막아준다.
- 구조체는 상속이 없으므로 convenience 이니셜라이저가 필요없어서 위와같은 에러가 발생한다.