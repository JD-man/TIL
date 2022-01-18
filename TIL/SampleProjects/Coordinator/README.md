# Coordinator Pattern

## 목차
1. 의의
2. 기본형태
3. 예시

---

## 1. 의의
- VC 다이어트 시키기.
- VC가 담당하던 화면전환코드마저 뺏어간다.
- VM로 비즈니스코드도 옮기고 Coordinator로 화면전환코드도 가져가서 VC는 뼈만남을듯.
- 화면전환 및 계층을 관리하는 Coordinator를 만들어 관리를 더 편하게 해주는데 의의가 있다.
- Coordinator를 통한 화면 전환시 ViewModel을 함께 주입할 수 있다!!

---

# 2. 기본형태

```swift
protocol CoordinatorType {
    var childCoordinators: [CoordinatorType] { get set }
    var navigationController: UINavigationController { get set }
    
    func start()
}
```
- 다음과 같은 프로퍼티, 메서드를 가지고 있는 프로토콜을 채택한다.
- 기본적으로 childCoordinators와 navigationController를 가진다.
- 그리고 시작점인 start() 함수를 가지고 있다.

```swift
class MainCoordinator: NSObject, CoordinatorType {
    
    var childCoordinators: [CoordinatorType] = []
    var navigationController: UINavigationController
    
    init(nav : UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        let vc = MainViewController()
        vc.coordinator = self        
        navigationController.pushViewController(vc, animated: true)
    }
}
```

- Coordinator는 NSObject와 CoordinatorType을 채택한다.
- 초기화로 UINavigationController를 받는다.
- 첫시작으로 MainVC를 navigationController에 push한다.

---

3. 예시 
```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let nav = UINavigationController()
        mainCoordinator = MainCoordinator(nav: nav)
        mainCoordinator?.start()
        
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
    }

    // ...
```

- 첫화면 코드.
- 블로그 예시들은 AppDelegate에서 하던데 나는 그냥 SceneDelegate에서 함. windowScene도 그대로 사용함
- mainCoordinator같은 경우 변수를 따로 만들어줘야 한다. VC에서 weak으로 참조하기 때문에 안그러면 메모리 해제된다.
- UINavigationController를 만들고 MainCoordinator에 사용한다. 그 nav가 rootVC가 된다.

```swift

// MainCoordinator.swift
weak var coordinator: MainCoordinator?

func pushSecondVC() {
    let vc = SecondViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
}

func pushThirdVC() {
    let vc = ThirdViewController()
    vc.coordinator = self
    navigationController.pushViewController(vc, animated: true)
}

//================================================================

// MainViewController.swift
@objc private func pushSecondVCButtonClicked() {
    coordinator?.pushSecondVC()
}

@objc private func pushThirdVCButtonClicked() {
    coordinator?.pushThirdVC()
}
```

- 화면전환 때문에 VC 인스턴스를 생성할때마다 coordinator 지정이 필요하다.
- coordinator 자체는 delegate처럼 사용된다.