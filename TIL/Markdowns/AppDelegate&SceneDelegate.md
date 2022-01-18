# AppDelegate & SceneDelegate

## 목차
1. iOS13 이전
2. iOS13 이후
3. 동작방식
4. 버전에 따른 Window RootViewController

---

## 1. iOS13 이전
- AppDelegate가 앱의 생명주기와 UI 라이프사이클을 모두 처리했음.
- AppDelegate에서 앱이 런치/종료되는지 앱이 백그라운드/포그라운드인지 모두 담당.
- AppDelegate에서 UIWindow 객체 구성, UIWindow를 통해 뷰컨트롤러를 화면에 표시하는 기능 담당.

---

## 2. iOS13 이후
- iPadOS의 멀티윈도우 기능이 등장하면서 UI 라이프사이클이 다양해짐.
- 아이패드에서 앱의 프로세스는 하나지만 여러 씬을 동시에 사용하게됨.
- SceneDelegate가 생겨 백그라운드/포그라운드 등의 UI 라이프사이클을 관리하게됨.
- SceneDelegate에서 UIWindow 관련 부분 담당.

---

## 3. 동작방식
### 1) 새로운 Scene이 필요
- AppDelegated의 application(_:ConfigurationForConnecting:options:) -> UISceneConfiguration 호출 후  
- SceneDelegate의 scene(_:willConnectTo:options:)가 호출

```swift
// AppDelegate와 SceneDelegate의 각 메소드에 print(#function)해보면 찍히는 순서
application(_:didFinishLaunchingWithOptions:)
application(_:configurationForConnecting:options:)
scene(_:willConnectTo:options:)
sceneWillEnterForeground(_:)
sceneDidBecomeActive(_:)
```

### 2) Scene 영구삭제
- AppDelegate의 application(_didDiscardSceneSessions:) 호출  
- 앱 실행이 안될때 시스템에 내부적으로 종료한것이라면 다음에 앱이 실행될때 호출된다.

---

## 4. Window RootController
- 버전에 따라 AppDelegate와 SceneDelegate의 역할이 다르다보니 스토리보드 없이 뷰를 시작하는 방법도 다르다.
- info.plist, main 삭제 등은 생략
### 1) iOS13 미만
```swift
// AppDelegate.swift

var window: UIWindow?

func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {    
    if #available(iOS 13.0, *) {
        
    }
    else {
        let rootViewController = RootViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
    return true
}
// MARK: UISceneSession Lifecycle
@available (iOS 13.0, *)
func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {    
    return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
}

@available (iOS 13.0, *)
func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {    
}
```

- application 메소드에 13.0 이상 표시를 해줘야함.

### 2) iOS13 이상
```swift
var window: UIWindow?

@available (iOS 13.0, *)
func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {    
    guard let windowScene = (scene as? UIWindowScene) else { return }
    window = UIWindow(windowScene: windowScene)        
    window?.rootViewController = RootViewController()
    window?.makeKeyAndVisible()
}
```
