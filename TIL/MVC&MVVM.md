# MVC & MVVM

## 목차
1. MVC
2. MVVM
3. 예제

---

## 1. MVC
### 1) 정의
- Model-View-Controller
- 하나의 화면을 위해 MVC 하나가 사용된다.
### 2) Model
- 앱의 본질적인 데이터 담당
- 화면과 상관없이 UI에 독립적이다
### 3) View
- Target-Action / @IBAction으로 Controller와 소통한다.
- Controller를 통해 Model을 업데이트할 수 있으며 이 경우 delegate, datasource 등의 프로토콜을 사용한다.
### 4) Controller
- Model이 화면에 어떻게 나올지 등 UI 로직 담당.

---

## 2. MVVM
### 1) 정의
- Model-View-ViewModel
- View와 Model을 명확하게 분리
- ViewModel을 통해 UI와 비즈니스 로직을 분리한다.
- MVC의 Controller는 View로 취급된다.
### 2) Model
- View와 독립적. UIKit, SwiftUI를 import하지 않는다.
- Model의 변경을 ViewModel에 알려준다.
### 3) View
- ViewModel을 참조하고 있다.
- UI 로직은 이제 ViewModel에 있다.
- ViewModel은 Publish하고 View는 그 내용을 subscribe 및 observe.
### 4) ViewModel
- Model을 참조하고 있다.
- View로 변경사항 입력 -> ViewModel -> Model 업데이트 및 변경 -> ViewModel -> View 반영
- Interpreter의 역할
- View에 변경 사항을 직접 알리지는 않고, 변경내용을 Publish만 한다.

---

## 3. 예제
### 1) Observable
- listner를 만들고 value가 업데이트 될 때마다 listner를 실행한다.
- 따라서 listner는 value의 변경에 반응한다.
- lisnter의 내용은 bind를 통해 연결되는 escaping closure.
```swift
// Observable.swift
import Foundation

class Observable<T> {
    private var listner: ( (T) -> Void )?
    
    var value: T {
        didSet {
            listner?(value)
        }
    }
    
    init(_ value: T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        listner = closure
    }
}
```

### 2) ViewModel
- View가 관찰할 observable을 두개 만든다. (username, password)
- SignIn할 경우의 비즈니스 로직이 ViewModel에 들어간다. (postUserForSignIn)
```swift
//SignInViewModel.swift

import Foundation

class SignInViewModel {
    var usernameObservable: Observable<String> = Observable("")
    var passwordObservable: Observable<String> = Observable("")
    
    func postUserForSignIn(completion: @escaping () -> Void) {
        print("clicked")
        APIService.login(identifier: username.value, password: password.value) { userData, error in
            guard let userData = userData else {
                return
            }
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            UserDefaults.standard.set(userData.user.username, forKey: "username")
            completion()
        }
    }
}

```

### 3) View
- 1. bind를 통해 listner를 설정한다. 예제의 경우 TextField의 text를 업데이트한다.
- 2. Observable의 value를 업데이트하기 위해 TextField addTarget
- 3. SignIn 비즈니스 로직을 실행시키기 위한 button addTarget
```swift
import UIKit

class SignInViewController: UIViewController {
    let signInView = SignInView()
    var viewModel = SignInViewModel()
    
    // ...

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPink
        
        // 1. listner 설정
        viewModel.usernameObservable.bind { text in
            self.signInView.usernameTextField.text = text
        }
        viewModel.passwordObservable.bind { text in
            self.signInView.passwordTextField.text = text
        }
        
        // 2. Observable의 value 업데이트
        signInView.usernameTextField.addTarget(self, action: #selector(usernameTextFiledDidChange(_:)), for: .editingChanged)
        signInView.passwordTextField.addTarget(self, action: #selector(passwordTextFiledDidChange(_:)), for: .editingChanged)

        // 3. SignIn
        signInView.signInButton.addTarget(self, action: #selector(signInButtonClicked), for: .touchUpInside)
    }
    
    @objc func usernameTextFiledDidChange(_ textfield: UITextField) {
        viewModel.username.value = textfield.text ?? ""
    }
    
    @objc func passwordTextFiledDidChange(_ textfield: UITextField) {
        viewModel.password.value = textfield.text ?? ""
    }

    // 내부적으로 ViewModel의 value를 사용하기 때문에 completion만 설정해주면 된다.
    @objc func signInButtonClicked() {
        viewModel.postUserForSignIn {
            DispatchQueue.main.async {
                guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else { return }
                windowScene.windows.first?.rootViewController = UINavigationController(rootViewController: MainViewController())
                windowScene.windows.first?.makeKeyAndVisible()
            }
        }
    }
}
```