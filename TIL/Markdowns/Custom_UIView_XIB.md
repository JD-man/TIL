# Custom UIView XIB. @IBInspectable/@IBDesignable

## File's Owner 설정

## Safe Area Layout Guide & Freeform Size
- Custom UIView는 Safe Area 설정이 필요없으므로 체크해제한다.
- XIB 생성시 뷰컨트롤러 모양을하고 있는데 Freeform size로 변경하고 사이즈를 조절해 사용한다.

---

## Initializer
### 1. required init?(coder: NSCoder)
- XIB는 xml형태로 Interface Builder 정보를 가지고 있다.
- XIB는 Nib으로 Deserialize되며 컴파일전 unarchiving된다.
- UIView는 NSCoding 프로토콜을 채택하고있어, Interface Builder를 사용한다면  
  NSCoder가 필요하며 required init이 사용된다.

### 2. override init(frame: CGRect)
- Interface Builder를 사용안하고 코드로만 만드는 경우
- required init? 호출이 필요하긴하다.

---

## Load NIB File
### 1. Bundle.main.loadNibNamed("name", owner: self, options: nil)
- nib 파일을 로드
```swift
let nib = Bundle.main.loadNibNamed("SquareBoxView", owner: self, options: nil)
let view = nib.first as! UIView
```

### 2.UINib(nibName: "name", bundle: nil)
- UINib: nib 파일을 캐시. instantiate 시점에 Unarchiving
```swift
let nib = UINib(nibName: "SquareBoxView", bundle: nil).instansiate(withOwner: self, options: nil)
let view = nib.first as! UIView
```

---

## @IBDesignable, @IBInspectable

### 1. @IBInspectable
- Insterface Builder Inspector 창에서 속성을 조절하게 한다.
### 2. @IBDesignable
- @IBInspectable에서 변경한 속성을 스토리보드에서 바로 확인하게 해준다.