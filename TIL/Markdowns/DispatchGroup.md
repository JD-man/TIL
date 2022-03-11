# DispatchGroup

목차
1. 의의
2. group.enter() / group.leave()
3. group.wait()
4. group.notify()

---

## 1. 의의
- DispatchQueue를 이용한 작업들을 묶어 모든 작업들이 끝나는 시점을 알기 위해 사용
- 특히 비동기 코드들을 사용하는 경우에 좋다.

---

## 2. group.enter() / group.leave()

```swift
let group = DispatchGroup()
let queue = DispatchQueue.global(qos: .userInitiated)
    
group.enter()
queue.async {    
    // Task...
    group.leave()    
}
```

- DispatchGroup을 만들고 비동기 코드 전에 enter, 비동기 코드의 작업 후에 leave
- enter와 leave는 짝이 맞아야 한다.

```swift
DispatchQueue.global().async(group: group) {
    // Task 1
}

DispatchQueue.global().async(group: group) {
    // Task 2
}

DispatchQueue.global().async(group: group) {    
    // Task 3
}
```

- enter와 leave 없이 이런 형태로 사용하는것도 가능

---

## 3. group.wait()
- 동기적으로 작동한다.
- group의 모든 작업이 끝날때까지 **기다린다**.
- wait 이후의 코드는 그 전까지 실행되지 않는다.

```swift
let group = DispatchGroup()
let queue = DispatchQueue.global()

group.enter()
queue.async {
    Thread.sleep(forTimeInterval: 1.0)
    print("leave 1")
    group.leave()
}

group.enter()
queue.async {
    Thread.sleep(forTimeInterval: 2.0)
    print("leave 2")
    group.leave()
}

group.wait()
print("finished")

/*
1초 후 leave 1 출력
2초 후 leave 2, fisnished 출력
*/
```

---

## 4. group.notify()

- notify는 비동기적으로 작동한다.

```swift
let group = DispatchGroup()
let queue = DispatchQueue.global()

group.enter()
queue.async {
    Thread.sleep(forTimeInterval: 1.0)
    print("leave 1")
    group.leave()
}

group.enter()
queue.async {
    Thread.sleep(forTimeInterval: 2.0)
    print("leave 2")
    group.leave()
}

group.notify(queue: queue) {
    print("notify")
}
print("finished")

/*
실행 후 finished 출력
1초 후 leave 1 출력
2초 후 leave 2, notify 출력
*/
```
---
