# App's Life Cycle

- [참고자료](https://developer.apple.com/documentation/uikit/app_and_environment/managing_your_app_s_life_cycle)

## 목차
1. 의의
2. Scene Based Life Cycle
3. App Based Life Cycle

---

## 1. 의의
- 앱의 시작, 종료, 백그라운드 진입 등 앱의 상태 또는 변화를 말한다.
- iOS 13버전 이상은 Scene Based Life Cycle을 가지고 미만은 App Based Life Cycle을 가진다.
- 전자는 SceneDelegate & AppDelegate, 후자는 SceneDelegate가 사용되지 않는다.

---

## 2. Scene Based Life Cycle
### 1) 의의
- iOS 13버전 이상에서 사용된다.
- scene은 디바이스에서 실행되고 있는 UI의 인스턴스다.
- UIKit은 각각의 scene에 생명주기 이벤트를 전달한다.
- 유저는 여러개의 scene을 생성할 수 있고 각각 다른 생명주기를 가질 수 있다.

### 2) State

1. Unattached
2. Foreground Inactive
3. Foreground Active
4. Background
5. Suspended

- 유저 또는 시스템이 앱에 새로운 Scene을 요청한다.
- 이 때 UIKit은 앱을 unattached state로 만든다.
- 유저가 요청한 Scene은 Foreground로 가고 시스템이 요청한 Scene은 Background로 간다.
- Launch Screen UI 일때 Foreground Inactive 상태다.
- 전자는 화면에 표시하기 위해서, 후자는 이벤트를 생성하기 위해서
- Foreground Active 상태에서 나올때 Background ~ Suspended 상태가 된다.

### 3) 관련 메소드
```swift
    // SceneDelegate.swift

    // 앱에 scene이 추가됨
    // AppDelegate의 application(_:didFinishLaunchingWithOptions:) 이후 실행됨.
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) 
    
    // scene이 제거됨
    // 이후 AppDelegate의 application(_:didDiscardSceneSessions:)이 실행됨
    func sceneDidDisconnect(_ scene: UIScene)

    // scene이 active 상태가 됐고 유저 이벤트에 반응함
    func sceneDidBecomeActive(_ scene: UIScene)
    
    // scene이 active 상태를 벗어나 유저 이벤트에 반응하지 않음
    func sceneWillResignActive(_ scene: UIScene)

    // scene이 Foreground로 들어오고 user에게 보일것
    func sceneWillEnterForeground(_ scene: UIScene)

    // scene이 스크린에서 안보이고 background로 들어감    
    func sceneDidEnterBackground(_ scene: UIScene)
```

---

## 3. App Based Life Cycle
### 1) 의의
- iOS 13버전 미만에서는 scene을 지원하지 않는다.
- 따라서 UIKit은 UIApplicationDelegate에 모든 생명주기 이벤트를 전달한다.

### 2) State

1. Not Running
2. Inactive
3. Active
4. Background
5. Suspended

- 앱이 실행된 이후에 UI가 화면에 표시되는지에 따라서 inactive 또는 background 상태가 된다.
- foreground로 들어왔다면 자동으로 active 상태로 만들어준다.
- 그 후의 상태는 앱이 종료되기 전까지 active와 background 상태를 왔다갔다 한다.

### 3) 관련 메소드
```swift
// AppDelegate.swift

// 실행은 시작했지만 state restoration이 아직 일어나지 않은 상태
// state restoration : 앱의 이전 상태를 복원하는것 ex) 종료 전 마지막 화면
func application(UIApplication, willFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool
// 앱이 거의 준비가 됨.
func application(UIApplication, didFinishLaunchingWithOptions: [UIApplication.LaunchOptionsKey : Any]?) -> Bool

// 새로운 화면의 설정
func application(UIApplication, configurationForConnecting: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration
// 종료될 때
func application(UIApplication, didDiscardSceneSessions: Set<UISceneSession>)

// 메소드 이름이 노골적이다
func applicationDidBecomeActive(UIApplication)
func applicationWillResignActive(UIApplication)
func applicationDidEnterBackground(UIApplication)
func applicationWillEnterForeground(UIApplication)
func applicationWillTerminate(UIApplication)
```