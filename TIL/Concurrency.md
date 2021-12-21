# Concurrency

## 목차
1. Concurrency
2. Asynchronous Functions
3. Asynchroouns Sequences
4. Parallel
5. Task, Task Groups
6. Unstructured Concurrency
7. Cancel
8. Actors

---

## 1. Concurrency
### 1) 의의
- Swift는 asynchronous, parallel 코드를 지원한다.
- 아래와 같은 기존의 completion handler의 복잡한 코드를 대체할 수 있다.

```swift
listPhotos(inGallery: "Summer Vacation") { photoNames in
    let sortedNames = photoNames.sorted()
    let name = sortedNames[0]
    downloadPhoto(named: name) { photo in
        show(photo)
    }
}
```

### 2) Asynchronous code
- 멈췄다가 재개할 수 있는 코드.
- 네트워크와 같은 시간이 걸리는 작업을 계속 하는 중에도 짧은 시간이 걸리는 UI 업데이트가 진행된다.

### 3) Parallel code
- 동시에 여러개가 실행되는 코드

### 4) parallel and asynchronous
- 한번에 여러개의 작업을 할 수 있게 해준다.
- memory-safe하며, 외부 시스템을 기다리는 동안 작업을 중단시킬 수 있다.

## 2. Asynchronous Function
### 1) 정의
- Asynchronous Function 또는 Method는 잠시 중단될 수 있다.
- 완료까지 실행되고 에러를 던지거나 리턴하지 않는 synchronous function과 다르다.
- 위의 세가지 모두 가능하기도 하지만 무언가를 기다리기 위해 잠시 중단할 수 있다.
- method 안의 body에 어디서 멈출지 표시할 수 있다.

### 2) 예시
```swift
func listPhotos(inGallery name: String) async -> [String] {
    let result = // ...
    return result
}
```

- 파라미터 뒤에 async를 사용하여 asynnchronous function임을 표시한다.
- 에러를 던진다면 async throws 순으로 작성한다.

```swift
let photoNAmes = await listPhotos(inGallery: "Summer Vacation")
let sortedNames = photoNames.sorted()
let name = sortedNames[0]
let photo = await downloadPhoto(named: name)
show(photo)
```

- 위에서 작성한 completion handler가 중복된 코드는 위와같이 변경된다.
- async function 앞에 await을 작성해서 사용한다.
- async function을 호출하면 리턴될때까지 실행이 중단된다.
- asnyc function 내부에서의 실행 흐름은 내부의 다른 async function이 호출되면 중단된다.
- 상대적으로 시간이 걸리는 listPhotos와 downloadPhotos를 async로 만들어 기다리는 동안 코드를 멈추고 앱의 나머지를 실행하게 한다.

### 3) 