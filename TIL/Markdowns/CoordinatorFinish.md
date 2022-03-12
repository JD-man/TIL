# Coordinator Finish Delegate

## 목차
1. 필요 이유
2. Child Coordinator
3. Parent Coordinator

---

## 1. 필요 이유
- 화면을 변경할 필요가 있어 다른 코디네이터로 전환하는 등 코디네이터의 역할을 다할 때가 있다.
- 이 때 역할을 다한 코디네이터를 없애주고 상위 코디네이터를 통해 다른 코디네이터로 전환을 해야한다.

---

## 2. Parent Coodinator

```swift
protocol ParentCoordinatorFinishDelegate: AnyObject {
    func didFinish(_ coordinator: CoordinatorType, next: AppCordinatorChild, completion: (() -> Void)?)
}
```

- 프로토콜을 만들고 하위 코디네이터 종료시 동작할 메서드를 만든다.

```swift
func addChildCoordinator() {    
    // ...    
    childCoordinator.finishDelegate = self
    // ...
}
```

- 하위 코디네이터는 finishDelegate로 상위 코디네이터를 가진다.

```swift
extension ParentCoordinator: ParentCoordinatorFinishDelegate {
    func didFinish(_ coordinator: CoordinatorType, next: ParentCordinatorChild, completion: (() -> Void)?) {
        childCoordinators = childCoordinators.filter { !($0 === coordinator) }
        switch next {
        case .child1:
            addChildCoordinator()
        case .child2:
            addChild2Coordinator()
        }
        var navArr = navigationController.viewControllers
        let last = navArr.last
        navArr.removeAll()
        navArr.append(last!)
        navigationController.viewControllers = navArr
        guard let completion = completion else { return }
        completion()
    }
}
```

- 하위 코디네이터가 종료되어 delegate를 통해 종료 메서드를 호출하게 된다.
- 이때 상위 코디네이터의 하위 코디네이터 Array에서 제거해준다.
- 그리고나서 화면을 바꾸기 위해 최상위 navigation controller의 viewControllers를 바꿔준다.  
  (하위 coordiantor 시작시 push로 들어가는 뷰가 없다면 이 과정은 필요 없다.) 

---

## 3. Child Coordinator

```swift
final class ChildCoordinator: CoordinatorType {
    weak var parentCoordinator: CoordinatorType?    
    weak var finishDelegate: AppCoordinatorFinishDelegate?

    // ...

    func finish(to next: AppCordinatorChild, completion: (() -> Void)?) {
        finishDelegate?.didFinish(self, next: next, completion: completion)
    }

    // ...
}
```

- ChildCoordinator는 parentCoordinator를 가진다.
- 그리고 parentCoordinator를 finishDelegate로 한다.
- 모든 역할을하고 종료될 때 finish 메서드를 호출하며 자기자신을 넘겨준다.  
  (다음 코디네이터나 completion은 없어도 된다. 프로젝트의 기획에 따라 필요해서 넣었다.)

---