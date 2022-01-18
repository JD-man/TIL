# Writing High-Performance Swift Code

- [참고자료1 - Apple/Swift Github](https://github.com/apple/swift/blob/main/docs/OptimizationTips.rst#advice-use-final-when-you-know-the-declaration-does-not-need-to-be-overridden)
- [참고자료2 - WWDC](https://developer.apple.com/videos/play/wwdc2016/416/)
- [참고자료3](https://www.rightpoint.com/rplabs/switch-method-dispatch-table)

## 목차
1. Enabliing Optimizations
2. WMO
3. Reducing Dynamic Dispatch
4. Tips

---

## 1. Enabling Optimizations
- Swift의 3가지 최적화 수준
- Targets -> Optimization 검색 -> Swift Compiler - Code Generation
- 여기에서 Optimization Level에서 최적화 수준 조절

### 1) -Onone
- 최소한의 최적화를 수행.
- 모든 디버그 정보를 보존.
- 주로 Debug 모드에서 사용.

### 2) -O
- Production, Release 모드에서 사용.
- 디버그 정보가 손실될 수 있지만 적극적인 최적화.

### 3) -OSize
- 성능보다 코드 크기를 우선하는 특수한 최적화 모드.

---

## 2. WMO
- Whole-Module-Optimization
- 기본적으로 Swift는 각 파일을 개별적으로 컴파일하지만 Whole Module이 설정되어 있다면 하나의 파일인 것처럼 컴파일한다.
- 컴파일 자체의 시간은 오래걸릴 수 있지만, 실행은 더 빨리 이루어질 수 있다.

---

## 3. Reducing Dynamic Dispatch
### 1) Method Dispatch
- 프로그램이 어떤 연산을 통해 메서드를 실행할지 정하는 메커니즘
- 코드 실행에 대한 결정이 컴파일때 이루어지는지 런타임에 이루어지는지에 따라 결정된다.
- 위 방법에 따라서 Static Dispatch인지 Dynamic Dispatch인지 결정된다.

### 2) Static Dispatch (Direct Call)
- 컴파일 타임에 호출되는 함수가 무엇인지 결정.
- 런타임에서는 판단할 필요가 없으므로 성능상의 이점이 있다.

### 3) Dynmic Dispatch (Indirect Call)
- 런타임에 호출되는 함수가 무엇인지 결정된다.
- 클래스를 상속하는 경우 오버라이딩 때문에 컴파일때 어떤 메서드가 실행되는지 결정하지 못한다.
- 따라서 런타임때 결정이되며 이 때는 vTable을 참조해서 결정한다.
- 참조 타입만 지원한다.

---

## 4. Tips
### 1) final
- Dynamic Dispatch로 실행되는 Class를 Static Dispatch로 사용하게 하는 방법.
- 클래스 만들때 final을 추가
- 클래스 내부의 프로퍼티와 메서드에서도 사용 가능
- 상속하지 않으므로 컴파일 시점에 어떤 메서드가 실행되는지 결정할 수 있어 성능에 이점이 있다.

### 2) fileprivate, private
- fileprivate와 private를 선언하면 컴파일러가 특정 파일에 제한되는 것을 확인한다.

### 3) Internal
- Internal 접근 제어가 선언이 되어 있는 경우, 모듈 외부에서 접근할 필요가 없다는 것을 컴파일러가 이해함.
- 모듈 외부에서는 final을 내부적으로 유추할 수 있다.
