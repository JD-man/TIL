# Transfer Value To Previous View

## 의의
- 앞으로 표시될 뷰로 값을 전달할 때는 present 또는 push하기 전에 뷰 객체 생성 후 프로퍼티를 이용했다.
- 이전 뷰로 돌아갈 때 현재 뷰의 값을 어떻게 전달할까???
- presentingView = 이전 뷰, presentedView = 현재 뷰

## 방법
1. Closure
2. NotificationCenter
3. Delegate

---

## Closure
- 현재 뷰에 클로저를 받을 프로퍼티를 생성하고 이전 뷰에서 현재 뷰 인스턴스를 생성할 때 클로저를 할당한다.
- 클로저를 사용하므로 Retain Cycle에 주의해야한다.
```swift
// 이전 뷰의 현재 뷰 present 버튼 함수
@IBAction func buttonClicked(_ sender: UIButton) {
        
    let vc = MyPresentedView()
    ...
    vc.buttonActionHandler = { [weak self, weak vc] in
        // 현재 뷰에서 buttonActionHandler가 실행되면 
        // 이전 뷰의 textView.text가 현재 뷰의 textView.text로 변경된다.            
        self?.textView.text = vc?.textView.text
    }
    ...        
    present(vc, animated: true, completion: nil)
}

//===========================================================================

// 현재 뷰 클래스
class MyPresentedView: UIViewController {
    // 이전 뷰에 현재 뷰의 값을 전달할 클로저
    var buttonActionHandler: (() -> ())!

    ...

    @IBAction func buttonClicked(_ sender: UIButton) {
        buttonActionHandler()
        dismiss(animated: true, completion: nil)
    }

    ...
}
```

---

## NotificationCenter
- 선 addObserver 후 post
- deinit 또는 viewDidDisappear시 등록한 Notification 삭제 필요

```swift
// 이전 뷰에 addObserver
override func viewDidLoad() {
    super.viewDidLoad()
    
    NotificationCenter.default.addObserver(self, selector: #selector(firstNotification(noti:)), name: .firstNotification, object: nil)
}
// post시 실행 될 함수
@objc func firstNotification(noti: Notification) {
    print("notification")
    guard let userInfo = noti.userInfo else {
        return
    }
    print(userInfo)
}

//===========================================================================

// 현재 뷰에서 post
@IBAction func notificationButtonClicked(_ sender: UIButton) {
        
    NotificationCenter.default.post(name: .firstNotification,
                                    object: nil,
                                    userInfo: ["text" : textView.text!,
                                               "value" : 123])
    
    dismiss(animated: true, completion: nil)
}
```

---

## Delegate
- 현재 뷰의 Protocol을 생성 후 이전 뷰를 Delegate로 지정

```swift
class MyPresentingView: UIViewController, PassDataDelegate {
    
    func sendTextData(text: String) {
        textView.text = text
    }

    ...

    @IBAction func notificationButtonClicked(_ sender: UIButton) {
        let vc = MyPresentedView()
        vc.modalPresentationStyle = .fullScreen
        vc.delegate = self        
        present(vc, animated: true, completion: nil)
    }

    ...
}

//===========================================================================

// 현재 뷰의 Protocol
protocol PassDataDelegate: AnyObject {
    func sendTextData(text: String)
}

...

var delegate: PassDataDelegate?

@IBAction func protocolButtonClicked(_ sender: UIButton) {    
    delegate?.sendTextData(text: textView.text!)    
    dismiss(animated: true, completion: nil)
}

...
```