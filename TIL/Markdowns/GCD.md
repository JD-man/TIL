# 동시성 프로그래밍과 GCD

## 목차
1. 동시성 프로그래밍
2. GCD
3. Queue의 종류
4. DispatchQueue
5. 동기, 비동기
6. 직렬, 동시
7. DispatchQueue의 사용
8. Deadlock

---

## 1. 동시성 프로그래밍
- 하나의 스레드에서의 작업을 다른 스레드로 분산시켜 동작하게하는 프로그래밍
- 여러개의 스레드가 번갈아 가면서 실행되는 방식
- iOS에서는 GCD로 처리한다

---

## 2. GCD (Grand Central Dispatch)
- GCD는 iOS 등에서 멀티코어 하드웨어 동시성 프로그래밍을 할 수 있도록 지원
- C언어로 작성된 저수준의 API

---

## 3. Queue의 종류
- GCD에서는 DispatchQueue / OperationQueue를 지원
- 보통은 GCD를 DispatchQueue라고 부르나 같은 개념은 아니다.
- OperationQueue는 작업취소, 일시중지 등의 DispatchQueue에서 구현하지 못하는 기능을 구현

---

## 4. DispatchQueue
- 하나의 스레드에서 보낸 작업을 받아서 여러 스레드로 분배.  
  (작업의 이동 : 하나의 스레드 -> DispatchQueue -> 여러 스레드)
- global, main, custom 세가지 종류가 있다.

---

## 5. 동기, 비동기

### 동기 (Synchronous)
- 스레드에서 큐로 작업을 보낸 후에 그 작업이 끝날 때까지 **작업을 보낸 스레드**의 다음 작업은 대기
- 결과의 순서가 중요할 때 동기 코드로 작성

### 비동기 (Asynchronous)
- 동기와 다르게 스레드의 다음 작업을 시작
- 작업의 순서는 보장되지 않는다
- 동기 코드가 모두 실행되고 비동기 코드가 실행된다

---

## 6. 직렬, 동시

### 직렬 (Serial)
- 큐에 들어온 작업을 스레드에 보낼 때 **하나의 스레드에만** 모두 보낸다.

### 동시 (Concurrent)
- 큐에 들어온 작업을 스레드에 보낼 때 **여러 스레드로** 나누어서 보낸다.

---

## 7. DispatchQueue의 사용

- 보통의 경우 main/global, 직렬/동시 각각 2개씩 세트로 4가지의 경우가 있다.  

```swift
DispatchQueue.main.sync {
    // Task
}

DispatchQueue.main.async {
    // Task
}

DispatchQueue.global().sync {
    // Task
}

DispatchQueue.global().async {
    // Task
}
```

- global sync는 실질적으로는 메인 스레드에서 실행
- **main sync는 Deadlock을 일으켜 앱이 꺼지게 된다.**

```swift
let queue = DispatchQueue(label: "CustomQueue", attributes: .concurrent)
queue.async {
    print("CustomQueue async")
}
```
- 커스텀 큐의 경우는 위와 같이 사용된다. 동시큐일지 직렬큐일지 선택해서 생성이 가능

---

## 8. Deadlock

### 정의
- 두개 이상의 스레드가 서로 상대의 작업이 끝나기를 기다려 작업이 끝나지 않는 상태
- 특히 주로 메인큐에서 동기처리할때 발생한다.

```swift
// 현재 작업이 메인스레드라면
DispatchQueue.main.sync {
    // Deadlock 발생
}
```

### 발생이유
- 메인 스레드에서 큐로 작업을 보내면 메인큐는 동시큐이므로 메인 스레드에 받은 모든 작업을 넘긴다.
- 큐에서는 받은 작업을 메인스레드로 맨 마지막 순서로 보낸다.
- 하지만 동기 코드로 보냈기 때문에 메인 스레드의 다음 작업은 큐가 보낸 작업이 끝나야 실행된다.
- 먼저 끝나야 하는 작업이 뒤로 갔기 때문에 Deadlock이 발생하고 오류가 나와 앱이 종료된다.

### DispatchQueue.main.sync는 무조건 쓰면 안되는거??
```swift
DispatchQueue.global().async {
    print("global task 1")
    
    DispatchQueue.main.sync {
        print("main task 1: UI update")
    }
    
    print("global task 2: after UI update")
    
    DispatchQueue.main.sync {
        print("main task 2: UI update2")
    }
    print("global task 3: after UI update2" )
}

/*
global task 1

main task 1: UI update

global task 2: after UI update

main task 2: UI update2

global task 3: after UI update2
*/
```

- 만약 메인스레드에서의 작업이 다시 동기코드로 메인스레드로 오는 것이 아니라면 실행이 잘된다.
- 네트워크 작업에서 순서가 중요한 경우에는 이런 방식을 사용해도 좋아보인다.

---

