# Top-Level Code, Top-Level Entry Point, @main

## 목차
1. 의의
2. Top-Level Code
3. Top-Level Entry Point와 @main

---

## 1. 의의
- Top-Level Entry Point를 포함하고 있는 타입이라고 알리는 Attribute
- 클래스, 구조체, 열거형에 적용 가능

```swift
@main
struct MyTopLevel {
    static func main() {
        // top-level code        
    }
}

protocol ProvidesMain {
    static func main() throws
}
```

- 직접 @main을 구조체 등에 사용한다. 그 뒤에 main과 관련된 함수를 정의해야한다.
- 첫번째는 아무 인수가 없고 리턴이 없는 static main() 함수를 정의
- 두번째는 static func main() throws를 가지는 프로토콜을 채택하게 해서 정의

---

## 2. Top-Level Code
### 1. 의의
- 1개의 스위프트 소스 파일안의 top-level code는 0개 이상의 선언, 정의로 이루어져있다.
- 같은 모듈안의 모든 소스파일에서 접근할 수 있다.
- access-level modifier을 통해 override도 가능

### 2. 종류
- top-level declaration, executable top-level code 두개가 있다.

#### 1. Top-Level Declaration
- 오직 선언만 사용할 수 있다. (변수, 상수의 선언 열거형의 정의 등..)
- 모든 스위프트 소스파일에서 작성 가능하다.


#### 2. Executable top-level code
- 선언 뿐만 아니라 명령문 또는 표현식도 작성가능하다. (print("JD") 등...)
- Top-Level Entry Point에서만 허용된다.

---

## 3. Top-Level Entry Point와 @main
- Top-Level Entry Point는 프로그램의 시작점이다.
- Top-Level Entry Point를 설정하는 방법은 5가지가 있다.
1. @main Attribute 사용
2. @NSApplicationMain Attribute 사용
3. @UIApplicationMain Attribute 사용
4. 1개의 main.swift 파일
5. top-level executable code를 가지는 1개의 파일

- 따라서 @main을 사용하는 이유는 프로그램의 Top-Level Entry Point을 알려주기 위함이다.
- 그래서 main 함수에 있는 Excutable Top-Level Code가 실행될 수 있다.

```swift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // ...
    }
}
```

- 프로젝트에서 @main은 AppDelegate 클래스에서 사용되고 있다.
- 시작점이기 때문에 AppDelegate에 있는 함수들이 먼저 실행되는듯
- 지들이 쓰려고 만든거 같다. Top-Level Entry Point를 커스텀해서 쓸일은 거의 없을거 같다.