# Coordinator Pattern

- [참고자료!]()

## 목차
1. 의의
2. 기본형태
3. 예시
4. ChildCoordinator??

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

## 3. 예시 
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

---

## 4. ChildCoordinator
- 책임과 역할을 분리하기 위해서 Coordinator도 계층을 만든다.

```swift
// ChildCoordinator
class AddCoordinator: NSObject, CoordinatorType {
    weak var parentCoordinator: MainCoordinator?
    
    var childCoordinators: [CoordinatorType] = []
    var navigationController: UINavigationController
    
    init(nav : UINavigationController) {
        self.navigationController = nav
    }
    
    func start() {
        let addVC = AddViewController()
        addVC.coordinator = self
        navigationController.pushViewController(addVC, animated: true)        
    }
    
    func pushSecondVC() {
        let addSecondVC = AddSecondViewController()
        addSecondVC.coordinator = self
        navigationController.pushViewController(addSecondVC, animated: true)
    }
}
```

- ChildCoordinator는 parentCoordinator를 가지고 있다. 바로 위층의 Coordinator

```swift
// MainCoordinator
var childCoordinators: [CoordinatorType] = []

func addCoordinate() {
    let child = AddCoordinator(nav: navigationController)
    child.parentCoordinator = self
    childCoordinators.append(child)
    child.start()
}
```

- parentCoordinator에서는 childCoordinator를 시작시키는 메서드가 추가된다.
- **여기서 childCoordinators에 append 시켜야한다.**

### **ChildCoordinator Array에 append 하는 이유!!**

- 이거에 대해서 공부할때 왜 array를 만들어서 append 해놓는지 몰랐다.
- 왜냐하면 append 안해도 child Coordinator의 start는 실행이되고 화면 전환이 되기 때문이다.
- 하지만 append 해놓지 않았다면 이 이후에 child Coordinator를 사용할 수 없다!!!

```swift    
    weak var coordinator: AddCoordinator?
```

- 모든 View Controller에서는 coordinator를 weak var로 가지고 있다.
- 그래서 addCoordinate() 메서드가 끝나면 child의 reference count는 0이되고 메모리 해제가 된다.

```swift
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    var mainCoordinator: MainCoordinator?

    // ...
}
```
- 그럼 MainCoordinator는?? SceneDelegate에서 선언하고 있어서 꽉 잡고있다.

### **append하고 전부 사용한 Coordinator 처리하기!!**

```swift
// Parent Coordinator
func childDidFinish(_ child: CoordinatorType?) {
    for (idx, coordinator) in childCoordinators.enumerated() {
        if coordinator === child {
            childCoordinators.remove(at: idx)
            break
        }
    }
}

// Child Coordinator
func didFinishChild() {
    parentCoordinator?.childDidFinish(self)
}

// First View Controller of Child Coordinator
override func viewDidDisappear(_ animated: Bool) {
    super.viewDidDisappear(animated)
    coordinator?.didFinishChild()        
}
```

- Parent Coordinator에는 완료된 Child Coordinator를 찾아서 제거하는 메서드를 만든다.
- Child Coordinator에는 Parent Coordinator의 제거 메서드를 사용하는 메서드를 만든다.
- 그리고 위 메서드를 Child Coordinator의 Start()에 있는 View Controller가 사라졌을때 실행한다.

#### UINavigationControllerDelegate를 사용하는 방법도 있다.
#### 모든 Coordinator에 추가하기는 부담스럽기도 해서 이 방법은 나중에 고려