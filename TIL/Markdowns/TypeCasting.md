# Type Casting

## 목차
1. 정의
2. as, as? ,as!

---

## 1. 정의
- 인스턴스의 타입을 체크하거나 superclass 또는 subclass로 다루는 것을 말한다.
- 인스턴스의 타입이 변하는건 아니다.
- 전자의 경우 is를 사용하고, 후자인 Downcasting의 경우 as를 사용한다.

---

## 2. as, as?, as!
### 1) 의의
- Downcasting에 사용한다. as는 Upcasting에도 사용한다.
- Downcasting의 경우 실패할 수 있기 때문에 as?, as! 두가지 타입이 있다.

### 2) as?
- Downcasting이 성공할지 확실하지 않을때 사용한다.
- 실패시 nil을 반환한다.

### 3) as!
- Downcasting이 성공할지 확실할때 사용한다.
- 실패시 런타임 에러가 난다.

### 3) as
- Upcasting에 사용할 수 있다.
- 컴파일 시점에 캐스팅이 가능한지 결정한다.